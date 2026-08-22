{den, ...}: {
  den.aspects.hierophant = {
    includes = with den.aspects; [network-manager impermanence ssh nix jellyfin close-lid boot];

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

      boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
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

      fileSystems."/var/lib/nixos" = {
        device = "/nix/persistent/var/lib/nixos";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/etc/nixos" = {
        device = "/nix/persistent/etc/nixos";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/home/anton/.gnupg" = {
        device = "/nix/persistent/home/anton/.gnupg";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/etc/NetworkManager/system-connections" = {
        device = "/nix/persistent/etc/NetworkManager/system-connections";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/home/anton/.local/share/keyrings" = {
        device = "/nix/persistent/home/anton/.local/share/keyrings";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/home/anton/.local/share/nvim" = {
        device = "/nix/persistent/home/anton/.local/share/nvim";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/home/anton/.local/share/zoxide" = {
        device = "/nix/persistent/home/anton/.local/share/zoxide";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/home/anton/.local/state/comma" = {
        device = "/nix/persistent/home/anton/.local/state/comma";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/home/anton/.local/state/nvim" = {
        device = "/nix/persistent/home/anton/.local/state/nvim";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/var/lob/journal" = {
        device = "/nix/persistent/var/lob/journal";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/var/lib/systemd/coredump" = {
        device = "/nix/persistent/var/lib/systemd/coredump";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/59EE-96F0";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };

      swapDevices = [];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  };
}
