{aspect-utils, ...}: let
  inherit (aspect-utils) self;
in {
  includes = [self.niri self.mango];
  provides.to-users.includes = [self.desktop-apps];
}
