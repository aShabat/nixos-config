{den, inputs, lib, ...} : let
root = "/dev/disk/by-label/nixos";
root-device = lib.concatStringsSep "-" (lib.tail (map (lib.replaceString "-" "\\x2d") (lib.splitString "/" root) )) + ".device";
directories = persist: lib.concatMap (p: p.directories or []) persist;
files = persist: lib.concatMap (p: p.files or []) persist;
home-directories = persist: lib.concatMap (p: p.home.directories or []) persist;
home-files = persist: lib.concatMap (p: p.home.files or []) persist;
in {
  flake-file.inputs.impermanence = {
    url = "github:nix-community/impermanence";
  };

  den.quirks.persist = {
    description = "impermanence files and directories";
  };

  den.aspects.impermanence = {
    nixos = {persist, ...} : {
      imports = [ (inputs.impermanence.nixosModules.impermanence or {}) ];

      fileSystems."/persistent".neededForBoot = true;
      environment.persistence."/persistent" = {
        enable = true;
	hideMounts = true;
	directories = [
	  "/etc/nixos"
	  "/var/lib/nixos"
	  "/var/lib/systemd/coredump"
	] ++ (directories persist);
	files = [
	] ++ (files persist);
      };

      boot.initrd = {
        supportedFilesystems = [ "btrfs" ];
	systemd.enable = true;
	systemd.services.restore-root = {
	  description = "Rollback btrfs root";
	  wantedBy = [ "initrd.target" ];
	  requires = [ root-device ];
	  after = [ root-device ];
	  before = [ "sysroot.mount" ];
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

    homeManager = {persist, ...} : {
      home.persistence."/persistent" = {
        enable = true;
	directories = [
		"testing_persistence"
	] ++ (home-directories persist);
	files = [
	] ++ (home-files persist);
      };
    };


  };
}
