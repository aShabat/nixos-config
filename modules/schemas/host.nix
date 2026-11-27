{den, ...}: {
  den.schema.host = {
    includes = with den.aspects; [
      den.batteries.user-aspects

      networking
      impermanence
      ssh
      ssh.netbird
      nix
      close-lid
      unfree
      boot
    ];
  };
}
