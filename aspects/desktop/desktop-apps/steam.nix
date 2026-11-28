{...}: let
  steam-home = "/persistent/steam-home";
in {
  nixos = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        extraEnv = {
          HOME = steam-home;
          XDG_DATA_HOME = "${steam-home}/.local/share";
          XDG_CONFIG_HOME = "${steam-home}/.config";
          XDG_STATE_HOME = "${steam-home}/.local/state";
          XDG_CACHE_HOME = "/home/anton/.cache";
        };
      };
    };
  };

  persist.home.directories = [".steam" ".local/share/Steam" ".local/share/vulkan"];
}
