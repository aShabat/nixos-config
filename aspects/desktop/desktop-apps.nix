{
  aspect-utils,
  pkgs,
  ...
}: {
  provides.to-users.includes = [aspect-utils.self];
  homeManager = {
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
