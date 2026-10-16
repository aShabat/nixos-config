{
  nixos = {
    programs.steam.enable = true;
  };

  persist.home.directories = [".steamd" ".local/share/Steam"];
}
