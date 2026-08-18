{den, ...}: {
  den.aspects.scribe = {
    includes = with den.aspects; [network-manager impermanence ssh nix close-lid boot cloudflared caddy pocket-id];

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

      boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
      boot.initrd.kernelModules = [];
      boot.kernelModules = ["kvm-intel"];
      boot.extraModulePackages = [];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/a4738734-ebc8-4ebc-ae5c-f83e02bf2830";
        fsType = "btrfs";
        options = ["subvol=root"];
      };

      fileSystems."/persistent" = {
        device = "/dev/disk/by-uuid/a4738734-ebc8-4ebc-ae5c-f83e02bf2830";
        fsType = "btrfs";
        options = ["subvol=persistent"];
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/a4738734-ebc8-4ebc-ae5c-f83e02bf2830";
        fsType = "btrfs";
        options = ["subvol=nix"];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/FF38-6ED9";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };

      swapDevices = [];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  };
}
