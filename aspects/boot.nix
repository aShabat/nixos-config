{
  nixos = {pkgs, ...}: let
    toml = pkgs.formats.toml {};
  in {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      kernelParams = ["quiet" "slpash"];
    };

    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet";
        };
      };
    };

    environment.etc."tuigreet/config.toml".source = toml.generate "config.toml" {
      session.sessions_dirs = [
        "/run/current-system/sw/share/wayland-sessions"
        "/etc/desktop-sessions"
      ];
      remember = {
        username = true;
        session = true;
        user_session = true;
      };

      display = {
        issue = true;
      };

      user_menu = {
        enabled = true;
        min_uid = 1000;
        max_uid = 2000;
      };
      secret.mode = "hidden";

      background.kind = "matrix";
    };
    environment.pathsToLink = ["/share/wayland-sessions"];
    environment.etc."desktop-sessions/fish.desktop".text = ''
      [Desktop Entry]
      Name=Fish Terminal
      Comment=Start a login shell
      Exec=${pkgs.fish}/bin/fish -l
      Type=Application
    '';
  };

  persist.directories = ["/var/cache/tuigreet"];
}
