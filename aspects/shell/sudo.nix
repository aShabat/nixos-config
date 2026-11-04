{
  nixos = {
    security = {
      sudo.enable = false;
      run0 = {
        enable = true;
        sudo-shim.enable = true;
        wheelNeedsPassword = false;
        persistentAuth = {
          enable = true;
          enableRemote = true;
        };
      };
      polkit = {
        settings.Polkitd.ExpirationSeconds = 600;
      };
    };
  };
}
