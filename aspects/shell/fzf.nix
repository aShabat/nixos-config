{
  homeManager = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = [pkgs.fd];
    programs.fzf = {
      enable = true;
    };
  };
}
