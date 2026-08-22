{den, ...}: {
  den.aspects.hierophant = {
    includes = with den.aspects; [network-manager impermanence ssh nix jellyfin qbittorrent close-lid boot];

    nixos = {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }: {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "uas" "usb_storage" "sd_mod"];
      boot.initrd.kernelModules = [];
      boot.kernelModules = ["kvm-intel"];
      boot.extraModulePackages = [];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/6eb3dd0f-a150-48ba-a3a4-9673e62aed31";
        fsType = "btrfs";
        options = ["subvol=root"];
      };

      fileSystems."/persistent" = {
        device = "/dev/disk/by-uuid/6eb3dd0f-a150-48ba-a3a4-9673e62aed31";
        fsType = "btrfs";
        options = ["subvol=persistent"];
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/6eb3dd0f-a150-48ba-a3a4-9673e62aed31";
        fsType = "btrfs";
        options = ["subvol=nix"];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/59EE-96F0";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };

      fileSystems."/hdd" = {
        device = "/dev/disk/by-uuid/a0612e41-7076-418d-9cd9-61ece503eac8";
        fsType = "ext4";
      };

      swapDevices = [];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  };
}
