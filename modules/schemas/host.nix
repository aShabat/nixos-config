{den, ...}: {
  den.schema.host = {
    includes = with den.aspects; [
      networking
      impermanence
      ssh
      ssh.netbird
      nix
      close-lid
      boot
    ];
  };
}
