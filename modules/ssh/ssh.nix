{lib, ...} : {
  den.aspects.ssh = {
    nixos = {user, ...} : {
      services.openssh = {
        enable = true;
	openFirewall = true;
	settings = {
	  PasswordAuthentication = false;
	  KbdInteractiveAuthentication = false;
	  PermitRootLogin = "no";
	  AllowUsers = [ user.userName ];
	  MaxAuthTries = 3;
	  PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
	};
      };
    };

    user = {
      openssh.authorizedKeys.keyFiles = let
        is-pub-key = path: lib.hasSuffix ".pub" (builtins.baseNameOf path);
      in 
      builtins.filter is-pub-key (lib.filesystem.listFilesRecursive ./.);
    };

    persist.files = builtins.map (key: "/etc/ssh/ssh_host_" + key) [ "ed25519_key" "ed25519_key.pub" "rsa_key" "rsa_key.pub" ];
    persist.home.files = [ ".ssh/id_ed25519" ".ssh/id_ed25519.pub" ];
  };
}
