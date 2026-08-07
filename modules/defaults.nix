{ lib, den, ... }:
{
  den.default.includes = with den.batteries; [ define-user hostname ];

  den.default.nixos.system.stateVersion = "26.05";
  den.default.homeManager.home.stateVersion = "26.05";

  den.default.nixos.time.timeZone = "Asia/Jerusalem";

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
