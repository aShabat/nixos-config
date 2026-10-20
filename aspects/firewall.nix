{
  nixos = {
    networking.firewall = {
      enable = true;
      allowPing = true;
    };
  };
}
