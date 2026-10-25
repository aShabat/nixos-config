{
  inputs,
  lib,
  aspect-utils,
  ...
}: let
  root = "/dev/disk/by-label/nixos";
  root-device = lib.concatStringsSep "-" (lib.tail (map (lib.replaceString "-" "\\x2d") (lib.splitString "/" root))) + ".device";
  collect-attrs = path: persist: lib.concatMap (p: lib.attrByPath path [] p) persist;
in {
  provides.to-users.includes = with aspect-utils; [self self.diff];
  nixos = {persist, ...}: let
    directories = collect-attrs ["directories"] persist;
    files = collect-attrs ["files"] persist;
  in {
    imports = [(inputs.impermanence.nixosModules.impermanence or {})];

    fileSystems."/persistent".neededForBoot = true;
    environment.persistence."/persistent" = {
      enable = true;
      hideMounts = true;
      directories =
        [
          "/etc/nixos"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/var/log/journal"
        ]
        ++ directories;
      files =
        [
        ]
        ++ files;
    };

    boot.initrd = {
      supportedFilesystems = ["btrfs"];
      systemd.services.restore-root = {
        description = "Rollback btrfs root";
        wantedBy = ["initrd.target"];
        requires = [root-device];
        after = [root-device];
        before = ["sysroot.mount"];
        unitConfig.DefaultDependenices = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          mkdir /btrfs-tmp
          mount -t btrfs ${root} /btrfs-tmp
          btrfs subvolume delete /btrfs-tmp/root -R
          btrfs subvolume create /btrfs-tmp/root
          umount /btrfs-tmp
          rmdir /btrfs-tmp
        '';
      };
    };
  };

  homeManager = {persist, ...}: let
    directories = collect-attrs ["home" "directories"] persist;
    files = collect-attrs ["home" "files"] persist;
  in {
    home.persistence."/persistent" = {
      enable = true;
      directories =
        [
          "Downloads"
          "Documents"
          "Projects"
        ]
        ++ directories;
      files =
        [
        ]
        ++ files;
    };
  };
}
