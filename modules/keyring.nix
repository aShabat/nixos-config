{
  den.aspects.keyring = {
    nixos = {
      services.gnome.gnome-keyring.enable = true;
    };

    homeManager = {pkgs, ...} : {
      services.gnome-keyring.enable = true;
      home.packages = [ pkgs.gcr ];

      programs.gpg.enable = true;
    };

    persist.home.directories = [
      ".local/share/keyrings"
      { directory = ".gnupg"; mode = "0700"; }
    ];
  };
}
