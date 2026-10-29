{aspect-utils, ...}:{
provides.to-users.includes = [ aspect-utils.self];
 homeManager = {
  programs = {
    firefox.enable = true;
    alacritty.enable = true;
  };
 };

 persist.home.directories = [ ".config/mozilla/firefox' ];
}
