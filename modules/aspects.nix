{lib, ...}: let
  isNixFile = path: lib.hasSuffix ".nix" (lib.baseNameOf path);
  isDir = path: !(lib.hasInfix "." (lib.baseNameOf path));

  scanAspectTree = accAttrPath: path: let
    name = lib.removeSuffix ".nix" (lib.baseNameOf path);
    attrPath = accAttrPath ++ [name];
  in
    if name == "default"
    then null
    else if isNixFile path
    then {
      inherit path name attrPath;
      kind = "file";
    }
    else if isDir path
    then
      assert !(lib.pathExists (path + ".nix")); let
        children = lib.pipe path [
          lib.readDir
          lib.attrNames
          (lib.map (n: path + "/${n}"))
          (lib.map (scanAspectTree attrPath))
          (lib.filter (a: !isNull a))
        ];
        hasDefault = lib.pathExists (path + "/default.nix");
      in {
        inherit path name attrPath children hasDefault;
        kind = "dir";
      }
    else null;

  generateAspectUtils = {
    attrPath,
    children,
    ...
  }: {
    includes-all-subaspects = den: lib.map (name: lib.getAttrFromPath (attrPath ++ [name]) den) (lib.map (c: c.name) children);
    includes-all-subaspects-except = exclude: den:
      lib.map (name: lib.getAttrFromPath (attrPath ++ [name]) den) (lib.subtractLists exclude (lib.map (c: c.name) children));
  };

  importWithArgs = args: config: {path, ...} @ aspectNode: let
    imported = import path;
  in
    if lib.isFunction imported
    then let
      required = lib.functionArgs imported;
      aspectArgs = lib.mapAttrs (name: _:
        args.${
          name
        } or config._module.args.${
          name
        } or (
          if name == "aspect-utils"
          then generateAspectUtils aspectNode
          else throw "Not a valid aspect arg"
        ))
      required;
    in
      imported aspectArgs
    else imported;

  generateAspectImports = {
    name,
    attrPath,
    hasDefault ? true,
    children ? [],
    ...
  } @ aspectNode:
    (
      if hasDefault
      then [
        (
          {config, ...} @ args: {den = lib.setAttrByPath attrPath (importWithArgs args config aspectNode);}
        )
      ]
      else if name == "aspects"
      then []
      else [
        ({den, ...}: {den = lib.setAttrByPath attrPath {includes = (generateAspectUtils aspectNode).includes-all-subaspects den;};})
      ]
    )
    ++ lib.concatMap generateAspectImports children;

  aspect-tree-imports = path: generateAspectImports (scanAspectTree [] path);
in {
  imports = aspect-tree-imports ../aspects;
}
