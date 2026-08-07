{den, ...} : {
  den.aspects.shell = {
    includes = with den.aspects; [
      git
      nh
      nix-index
      sudo
    ];
  };
}
