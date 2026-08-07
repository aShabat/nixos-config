{den, inputs, lib, ...} : let
  inherit (den.lib) policy;
  root = "/dev/disk/by-label/nixos";
  root-device = lib.concatStringsSep "-" (lib.tail (map (lib.replaceString "-" "\\x2d") (lib.splitString "/" root) )) + ".device";
  collect-attrs = path: persist: lib.concatMap (p: lib.attrByPath path [] p) persist;
in {
  flake-file.inputs.impermanence = {
    url = "github:nix-community/impermanence";
  };

  den.quirks.persist = {
    description = "impermanence files and directories";
  };

  den.policies.host-impermanence-for-users = { host, user, ...} : [
    (policy.include den.aspects.impermanence)
  ];

  den.aspects.impermanence = {
    includes = [ den.policies.host-impermanence-for-users ];
    nixos = {persist, ...} : let
      directories = collect-attrs [ "directories" ] persist;
      files = collect-attrs [ "files" ] persist;
    in {
      imports = [ (inputs.impermanence.nixosModules.impermanence or {}) ];

      fileSystems."/persistent".neededForBoot = true;
      environment.persistence."/persistent" = {
        enable = true;
	hideMounts = true;
	directories = [
	  "/etc/nixos"
	  "/var/lib/nixos"
	  "/var/lib/systemd/coredump"
	] ++ directories;
	files = [
	] ++ files;
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

    homeManager = {persist, ...} : let
      directories = collect-attrs [ "home" "directories" ] persist;
      files = collect-attrs [ "home" "files" ] persist;
    in {
      home.persistence."/persistent" = {
        enable = true;
	directories = [
	] ++ directories;
	files = [
	] ++ files;
      };
    };


  };
}
