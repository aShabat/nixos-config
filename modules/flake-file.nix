{
  lib,
  inputs,
  ...
}: let
  files = inputs.import-tree.leaves ./../aspects;
  fillArgs = func: lib.mapAttrs (_: null) (lib.functionArgs func);
  moduleOf = file:
    if lib.isFunction file
    then file (fillArgs file)
    else file;
  flakeFromFile = file: (moduleOf (import file)).flake-file or {};
  aspects-flake-file = lib.foldl' lib.recursiveUpdate {} (lib.map flakeFromFile files);
in {
  flake-file = lib.recursiveUpdate aspects-flake-file {
    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      home-manager = {
        url = "github:nix-community/home-manager/master";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      flake-file.url = "github:denful/flake-file";
      import-tree.url = "github:denful/import-tree";
      flake-parts = {
        url = "github:hercules-ci/flake-parts";
        inputs.nixpkgs-lib.follows = "nixpkgs";
      };
    };
    outputs = "dendritic";
  };

  imports = [inputs.flake-file.flakeModules.default];
}
