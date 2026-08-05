{
  den.aspects.keyring = {
    nixos = {
      services.gnome.gnome-keyring.enable = true;
    };

    homeManager = {pkgs, ...} : {
      services.gnome-keyring.enable = true;
      home.packages = [ pkgs.gcr ];
    };

    persist.directories = [
      ".local/share/keyrings"
    ];
  };
}
