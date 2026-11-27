{aspect-utils, ...}: {
  provides.to-users.includes = [aspect-utils.self];
  homeManager = {pkgs, ...}: {
    programs = {
      firefox = {
        enable = true;
        package = pkgs.firefox-devedition;
      };
    };
  };

  persist.home.directories = [".config/mozilla"];
}
