{
  den.aspects.network-manager = {
    nixos = {pkgs, ...}:
      !{
        networking.networkmanager = {
          enable = true;
          plugins = with pkgs; [networkmanager-openvpn];
        };
      };

    persist.directories = [
      "/etc/NetworkManager/system-connections"
    ];
  };
}
