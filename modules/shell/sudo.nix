{
  den.aspects.sudo = {
    nixos = {
      security.run0 = {
        enable = true;
	sudo-shim.enable = true;
      };
    };
  };
}
