{aspect-utils, ...}: {
  nixos = {
    programs.steam.enable = true;
  };

  persist.home.directories = [".steam" ".local/share/Steam"];

  provides.to-users = {includes = [aspect-utils.self];};
}
