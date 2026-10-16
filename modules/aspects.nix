{
  lib,
  config,
  ...
} @ args: let
  isNixFile = lib.hasSuffix ".nix";
  isDir = name: !(lib.hasInfix "." name);
  listChildren = path: lib.filter (name: (isNixFile name || isDir name) && name != "default.nix") (lib.attrNames (lib.readDir path));
  hasDuplicates = list: (lib.length list) != (lib.length (lib.unique list));
  hasDuplicateChildren = path: hasDuplicates (map (lib.removeSuffix ".nix") (listChildren path));
  hasDefault = path: lib.pathExists (path + "/default.nix");
  smartImport = path: let
    body = import path;
    bodyArgs = lib.functionArgs body;
    moduleArgs =
      lib.mapAttrs (
        name: _: args.${name} or config._module.args.${name}
      )
      bodyArgs;
  in
    if (lib.isFunction body)
    then (body (args // moduleArgs))
    else body;
  pathToAspectHelper = writeIncludes: path: let
    name = lib.baseNameOf path;
  in
    if (isNixFile name && name != "default.nix")
    then (smartImport path)
    else if (isDir name)
    then
      (
        if (hasDuplicateChildren path)
        then (throw "Duplicate aspect names")
        else if (hasDefault path)
        then (smartImport (path + "/default.nix"))
        else if writeIncludes
        then {includes = listSubAspects path {};}
        else {}
      )
      // lib.listToAttrs (lib.map (name: {
        name = lib.removeSuffix ".nix" name;
        value = pathToAspectHelper true (path + "/${name}");
      }) (listChildren path))
    else {};
  pathToAspect = pathToAspectHelper false;
  listSubAspects = path: opts:
    lib.map (name: pathToAspectHelper true (path + "/${name}"))
    (lib.filter (name: !(lib.elem (lib.removeSuffix ".nix" name) opts.exclude or [])) (listChildren path));
in {
  den.aspects =
    if (lib.pathExists ../aspects)
    then pathToAspect ../aspects
    else {};
  utils.aspects = {inherit listSubAspects;};
}
