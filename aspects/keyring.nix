{lib, ...}: {
  nixos = {
    services.gnome.gnome-keyring.enable = true;
  };

  homeManager = {
    pkgs,
    config,
    ...
  }: {
    services.gnome-keyring.enable = true;
    home.packages = [pkgs.gcr_3];

    programs.gpg.enable = true;

    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-curses;
    };

    home.file."${config.programs.gpg.homedir}/gpg.conf".force = lib.mkDefault true;
    home.file."${config.programs.gpg.homedir}/gpg-agent.conf".force = lib.mkDefault true;
  };

  persist.home.directories = [
    ".local/share/keyrings"
    {
      directory = ".gnupg";
      mode = "0700";
    }
  ];
}
