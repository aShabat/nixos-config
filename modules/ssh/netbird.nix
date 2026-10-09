{
  den,
  lib,
  ...
}: {
  den.aspects.netbird = {
    nixos = {
      services.netbird.clients.wl0 = {
        login = {
          enable = true;
          setupKeyFile = "/etc/nixos/modules/ssh/netbird_key.secret";
        };
        port = 51820;
      };
    };
  };
}
