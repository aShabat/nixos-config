{...}: {
  nixos = {
    services.netbird.clients.wl0 = {
      login = {
        enable = true;
        setupKeyFile = "${./netbird_key.secret}";
      };
      port = 51820;
    };
  };
  persist.directories = ["/var/lib/netbird-wl0/"];
}
