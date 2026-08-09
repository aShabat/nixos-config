{
  den.aspects.shell.zoxide = {
    homeManager = {
      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = ["--cmd" "cd"];
      };
    };

    persist.home.directories = [".local/share/zoxide"];
  };
}
