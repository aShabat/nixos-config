{den, ...}: {
  includes = with den.aspects; [
  ];

  nixos = {
    config,
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

    boot.initrd.availableKernelModules = ["xhci_pci" "virtio_pci" "virtio_scsi" "usbhid"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = [];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/a0eb1e70-3796-407b-9122-02a4b010fe6d";
      fsType = "btrfs";
      options = ["subvol=root"];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/a0eb1e70-3796-407b-9122-02a4b010fe6d";
      fsType = "btrfs";
      options = ["subvol=nix"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/C776-1373";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    fileSystems."/data" = {
      device = "/dev/disk/by-uuid/6d4278dd-f0be-4406-855f-0b63fe5cfd7f";
      fsType = "btrfs";
      options = ["subvol=main"];
    };

    fileSystems."/persistent" = {
      device = "/dev/disk/by-uuid/a0eb1e70-3796-407b-9122-02a4b010fe6d";
      fsType = "btrfs";
      options = ["subvol=persistent"];
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  };
}
