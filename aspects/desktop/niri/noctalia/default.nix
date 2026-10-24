{
  homeManager = {pkgs, ...}: {
    home.packages = [pkgs.noctalia];
  };
}
