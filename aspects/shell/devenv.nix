{
  homeManager = {pkgs, ...}: {
    home.packages = [pkgs.devenv];
  };

  persist.home.directories = [".local/share/devenv"];
}
