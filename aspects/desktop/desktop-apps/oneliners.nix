{
  homeManager = {
    programs.discord.enable = true;
  };

  persist.home.directories = [".config/discord" ".local/share/pki"];
}
