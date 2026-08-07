{
  den.aspects.firewall = {
    nixos = {
      networking.firewall = {
        enable = true;
	allowPing = true;
      };
    };
  };
}
