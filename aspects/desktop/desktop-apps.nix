{aspect-utils, ...}: {
  provides.to-users.includes = [aspect-utils.self];
  homeManager = {pkgs, ...}: {
    programs = {
      firefox = {
        enable = true;
        package = pkgs.firefox-devedition;
      };
      ghostty.enable = true;
    };
  };

  persist.home.directories = [".config/mozilla/firefox"];
}
