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

      fileSystems."/var/lib/nixos" = {
        device = "/persistent/persistent/var/lib/nixos";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/etc/NetworkManager/system-connections" = {
        device = "/persistent/persistent/etc/NetworkManager/system-connections";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/etc/nixos" = {
        device = "/persistent/persistent/etc/nixos";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/home/anton/.gnupg" = {
        device = "/persistent/persistent/home/anton/.gnupg";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/home/anton/.local/share/keyrings" = {
        device = "/persistent/persistent/home/anton/.local/share/keyrings";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/home/anton/.local/share/nvim" = {
        device = "/persistent/persistent/home/anton/.local/share/nvim";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/home/anton/.local/share/zoxide" = {
        device = "/persistent/persistent/home/anton/.local/share/zoxide";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/home/anton/.local/state/comma" = {
        device = "/persistent/persistent/home/anton/.local/state/comma";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/home/anton/.local/state/nvim" = {
        device = "/persistent/persistent/home/anton/.local/state/nvim";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/var/lib/bazarr" = {
        device = "/persistent/persistent/var/lib/bazarr";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/var/lib/private/prowlarr" = {
        device = "/persistent/persistent/var/lib/private/prowlarr";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/var/lib/radarr" = {
        device = "/persistent/persistent/var/lib/radarr";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/var/lib/sonarr" = {
        device = "/persistent/persistent/var/lib/sonarr";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/var/lib/systemd/coredump" = {
        device = "/persistent/persistent/var/lib/systemd/coredump";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/var/log/journal" = {
        device = "/persistent/persistent/var/log/journal";
        fsType = "none";
        options = ["bind"];
      };

      fileSystems."/swap" = {
        device = "/dev/disk/by-uuid/ae9a6937-bb0a-458a-8d94-18a0c4fd6794";
        fsType = "btrfs";
        options = ["subvol=swap"];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/48F3-5E52";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };

      swapDevices = [];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  };
}
