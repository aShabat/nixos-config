{aspect-utils, ...}: let
  inherit (aspect-utils) self;
in {
  includes = [self.niri];
  provides.to-users.includes = [self.desktop-apps];
}
