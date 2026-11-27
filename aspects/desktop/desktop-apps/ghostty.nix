{aspect-utils, ...}: {
  provides.to-users.includes = [aspect-utils.self];
  homeManager = {...}: {
    programs = {
      ghostty.enable = true;
    };
  };
}
