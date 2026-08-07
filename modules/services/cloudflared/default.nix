{lib, ...} : {
  den.aspects.cloudflared = {
    nixos = {host, ...} : let
      match-host =  hostName : host.hostName == hostName;
    in {
      services.cloudflared = {
        enable = true;
	certificateFile = ./cert.pem.secret;
	tunnels = {
	  "3ee421dd-2d64-4222-bec7-d6023865e11c" = lib.mkIf (match-host "hierophant") {
	    credentialsFile = ./3ee421dd-2d64-4222-bec7-d6023865e11c.json.secret;
	    default = "http://localhost:80";
	  };
	};
      };
    };
  };
}
