{aspect-utils, ...}: {
  provides.to-users.includes = [aspect-utils.self];

  nixos = {pkgs, ...}: {
    networking.networkmanager = {
      enable = true;
      plugins = with pkgs; [networkmanager-openvpn];
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  persist.directories = [
    "/etc/NetworkManager/system-connections"
    "/var/lib/bluetooth"
  ];
  persist.home.directories = [".local/share/networkmanagement"];
}
