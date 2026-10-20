{
  lib,
  den,
  ...
}: {
  den.default.includes = with den.batteries; [define-user hostname];

  den.default.nixos.system.stateVersion = "26.05";
  den.default.homeManager.home.stateVersion = "26.05";

  den.default.nixos.time.timeZone = "Asia/Jerusalem";

  den.schema.user.classes = lib.mkDefault ["homeManager"];
}
