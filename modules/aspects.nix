{lib, ...}: let
  isNixFile = lib.hasSuffix ".nix";
  isDir = name: !(lib.hasInfix "." name);
  listChildren = path: lib.filter (name: (isNixFile name || isDir name) && name != "default.nix") (lib.attrNames (lib.readDir path));
  hasDuplicates = list: (lib.length list) != (lib.length (lib.unique list));
  hasDuplicateChildren = path: hasDuplicates (map (lib.removeSuffix ".nix") (listChildren path));
  hasDefault = path: lib.pathExists (path + "/default.nix");
  pathToAspect = path: let
    name = lib.baseNameOf path;
  in
    if (isNixFile name && name != "default.nix")
    then (import path)
    else if (isDir name)
    then
      (
        if (hasDuplicateChildren path)
        then (throw "Duplicate aspect names")
        else if (hasDefault path)
        then (import (path + "/default.nix"))
        else {includes = listSubAspects path {};}
      )
      // lib.listToAttrs (lib.map (name: {
        name = lib.removeSuffix ".nix" name;
        value = pathToAspect (path + "/${name}");
      }) (listChildren path))
    else {};
  listSubAspects = path: opts:
    lib.map (name: pathToAspect (path + "/${name}"))
    (lib.filter (name: !(lib.elem (lib.removeSuffix ".nix" name) opts.exclude or [])) (listChildren path));
in {
  den.aspects =
    if (lib.pathExists ../aspects)
    then pathToAspect ../aspects
    else {};
  utils.aspects = {inherit listSubAspects;};
}
