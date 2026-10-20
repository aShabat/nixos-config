{
  services.logind = {
    enable = true;
    settings.Login = {
      HandleLidSwitch = "ignore";
    };
  };
}
