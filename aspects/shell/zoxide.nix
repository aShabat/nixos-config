{
  homeManager = {
    programs.zoxide = {
      enable = true;
      options = ["--cmd" "cd"];
    };
  };

  persist.home.directories = [".local/share/zoxide"];
}
