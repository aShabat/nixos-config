{...}: {
  den.aspects.shell.opencode = {
    homeManager = {
      programs.opencode = {
        enable = true;
        settings.default_agent = "plan";
      };
    };

    persist.home.directories = [
      ".config/opencode"
      ".local/share/opencode"
    ];
  };
}
