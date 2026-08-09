{den, ...}: {
  den.aspects.shell = {
    includes = with den.aspects.shell; [
      git
      nh
      nix-index
      sudo
      fish
      neovim
      fzf
      eza
      zoxide
    ];
  };
}
