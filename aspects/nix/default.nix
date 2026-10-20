{aspect-utils, ...}: {
  includes = aspect-utils.includes-all-subaspects;

  nixos = {
    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
