{
  den,
  lib,
  inputs,
  ...
}: let
  deep-flake-file = attr: lib.concatMapAttrs (_: deep-flake-file) attr // attr.flake-file or {};
  aspects-flake-file = deep-flake-file den.aspects;
in {
  flake-file =
    aspects-flake-file
    // {
      inputs.flake-file.url = "github:denful/flake-file";
    };

  imports = [inputs.flake-file.flakeModules.default];
}
