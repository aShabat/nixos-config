{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  scriptExtraPackages = path: let
    file = lib.readFile path;
    secondLine = lib.elemAt (lib.splitString "\n" file) 1;
    packageNames = lib.filter (name: name != "") (lib.splitString ";" (lib.removePrefix "# " secondLine));
  in
    lib.map (name: pkgs.${name}) packageNames;
  wrap-script = path: {
    exec = path;
    package = pkgs.coreutils;
    binary = "env";
    packages = scriptExtraPackages path;
  };

  hostname = lib.trim (lib.readFile /etc/hostname);
  scripts-from-dir = dirname:
    if lib.pathExists (./scripts + "/${dirname}")
    then
      lib.mapAttrs (name: _: wrap-script (./scripts + "/${dirname}/${name}"))
      (lib.filterAttrs (_: kind: kind == "regular") (lib.readDir (./scripts + "/${dirname}")))
    else {};

  host-scripts = scripts-from-dir hostname;
  common-scripts = scripts-from-dir "common";
in {
  packages = with pkgs; [
    alejandra
    stylua
    lua-language-server
    fish-lsp
    deploy-rs
  ];

  scripts = common-scripts // host-scripts;
}
