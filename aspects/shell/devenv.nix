{
  homeManager = {pkgs, ...}: {
    home.packages = [pkgs.devenv];
  };
}
