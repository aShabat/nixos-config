{...}: {
  den.aspects.gnome = {
    nixos = {pkgs, ...}: {
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;

      services.gnome = {
        core-apps.enable = false;
        core-developer-tools.enable = false;
        games.enable = false;
      };

      environment.gnome.excludePackages = with pkgs; [gnome-tour gnome-user-docs];
    };

    persist.directories = ["/var/lib/bluetooth"];
  };
}
