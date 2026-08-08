{
  den.aspects.close-lid.nixos = {
    services.logind = {
      enable = true;
      settings.Login = {
        HandleLidSwitch = "ignore";
      };
    };
  };
}
