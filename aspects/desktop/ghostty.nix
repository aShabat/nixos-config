{
  homeManager = {
    programs.ghostty.enable = true;
    programs.firefox.enable = true;
  };

  persist.home.directories = [".config/mozilla/firefox" ".mozilla"];
}
