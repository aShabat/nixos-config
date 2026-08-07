{
  den.aspects.cloudflared = {
    nixos = {
      services.cloudflared = {
        enable = true;
	certificateFile = ./cert.pem.secret;
	tunnels = {
	  "3ee421dd-2d64-4222-bec7-d6023865e11c" = {
	    credentialsFile = ./3ee421dd-2d64-4222-bec7-d6023865e11c.json;
	  };
	};
      };
    };
  };
}
