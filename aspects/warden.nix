{den, ...}: {
  includes = with den.aspects; [
    desktop
  ];

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

    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/44288f94-d407-4ea4-a84f-101a84927473";
      fsType = "btrfs";
      options = ["subvol=root"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/EB8B-3922";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/44288f94-d407-4ea4-a84f-101a84927473";
      fsType = "btrfs";
      options = ["subvol=nix"];
    };

    fileSystems."/persistent" = {
      device = "/dev/disk/by-uuid/44288f94-d407-4ea4-a84f-101a84927473";
      fsType = "btrfs";
      options = ["subvol=persistent"];
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
