{...}: {
  den.aspects.shell.opencode = {
    homeManager = {
      programs.opencode = {
        enable = true;
      };
    };

    persist.home.directories = [
      ".config/opencode"
      ".local/share/opencode"
    ];
  };
}
