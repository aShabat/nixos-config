{
  den.aspects.network-manager = {
    nixos = {
      networking.networkmanager.enable = true;
    };

    persist.directories = [
      "/etc/NetworkManager/system-connections"
    ];
  };
}
