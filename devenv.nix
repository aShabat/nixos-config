{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  packages = with pkgs; [alejandra stylua lua-language-server fish-lsp];

  scripts.ovpn-new-client = {
    exec = ./scripts/ovpn-new-client.fish;
    package = pkgs.fish;
    packages = with pkgs; [easyrsa util-linux];
  };
}
