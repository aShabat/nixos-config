{den, ...} : {
  den.aspects.hierophant = {
    includes = with den.aspects; [ network-manager impermanence ssh nix cloudflared caddy jellyfin close-lid boot ];

    nixos =
      { pkgs, ... }:
      {
        imports = [../old/hardware-configuration.nix];
      };
  };
}
