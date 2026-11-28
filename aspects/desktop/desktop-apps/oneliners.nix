{
  nixos = {pkgs, ...}: {
    services.udev.packages = with pkgs; [bazecor];
  };

  homeManager = {pkgs, ...}: {
    programs.discord.enable = true;
    xdg.configFile."discord/settings.json".enable = false;

    home.packages = with pkgs; [telegram-desktop bazecor];
  };

  persist.home.directories = [
    ".local/share/pki"
    ".config/discord"
    ".local/share/TelegramDesktop"
    ".config/Bazecor"
  ];
}
