{den, ...}: {
  den.aspects.archer = {
    includes = with den.aspects; [network-manager impermanence ssh nix close-lid boot];

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

      boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme"];
      boot.initrd.kernelModules = [];
      boot.kernelModules = ["kvm-intel"];
      boot.extraModulePackages = [];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/ae9a6937-bb0a-458a-8d94-18a0c4fd6794";
        fsType = "btrfs";
        options = ["subvol=root"];
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/ae9a6937-bb0a-458a-8d94-18a0c4fd6794";
        fsType = "btrfs";
        options = ["subvol=nix"];
      };

      fileSystems."/persistent" = {
        device = "/dev/disk/by-uuid/ae9a6937-bb0a-458a-8d94-18a0c4fd6794";
        fsType = "btrfs";
        options = ["subvol=persistent"];
      };

      fileSystems."/swap" = {
        device = "/dev/disk/by-uuid/ae9a6937-bb0a-458a-8d94-18a0c4fd6794";
        fsType = "btrfs";
        options = ["subvol=swap"];
      };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F962-80B8";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

      swapDevices = [];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  };
}
