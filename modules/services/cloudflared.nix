{
  den.aspects.cloudflared = {
    nixos = {
      services.cloudflared = {
        enable = true;
	certificateFile = ./cert.pem.secret;
      };
    };
  };
}
