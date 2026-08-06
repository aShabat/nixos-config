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

    homeManager = {host, user, ...} : {
      home.file.".ssh/id_ed25519".source = ./. + "/${user.userName}@${host.hostName}_ed25519";
    };
  };
}
