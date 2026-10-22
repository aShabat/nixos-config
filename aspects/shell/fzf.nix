{
  homeManager = {pkgs, ...}: {
    programs.fzf = {
      enable = true;
      defaultCommand = "${pkgs.fd/bin/fd} --type f";
    };
  };
}
