{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  packages = with pkgs; [alejandra stylua];
}
