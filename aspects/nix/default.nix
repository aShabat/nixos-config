{
  aspect-utils,
  lib,
  ...
}: {
  includes = aspect-utils.includes-all-subaspects;

  nixos = {
    nix.extraOptions = ''
      experimental-features = nix-command flakes
      access-tokens = github.com=${lib.trim (lib.readFile ./github-token.secret)}
    '';
  };
}
