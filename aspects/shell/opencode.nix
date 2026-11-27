{
  homeManager = {
    programs.opencode = {
      enable = true;
      settings.default_agent = "plan";
      mutableSettings = true;
    };
  };

  persist.home.directories = [
    ".config/opencode"
    ".local/share/opencode"
    ".local/share/opentui"
    ".local/state/opencode"
  ];
}
