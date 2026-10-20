{den, ...}: {
  den.schema.host = {
    includes = with den.aspects; [
      network-manager
      impermanence
      ssh
      ssh.netbird
      nix
      close-lid
      boot
    ];
  };
}
