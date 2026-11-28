{
  homeManager = {pkgs, ...}: {
    programs.discord.enable = true;
    xdg.configFile."discord/settings.json".enable = false;

    home.packages = with pkgs; [telegram-desktop];
  };

  persist.home.directories = [
    ".local/share/pki"
    ".config/discord"
    ".local/share/TelegramDesktop"
  ];
}
