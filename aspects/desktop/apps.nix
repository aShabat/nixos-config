{aspect-utils, ...}: {
  provides.to-users.includes = [aspect-utils.self];
  homeManager = {
    programs = {
      firefox.enable = true;
      ghostty.enable = true;
    };
  };

  persist.home.directories = [".config/mozilla/firefox"];
}
