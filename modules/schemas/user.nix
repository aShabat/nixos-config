{den, ...}: {
  den.schema.user = {
    includes = with den.aspects; [
      user-password
      shell
      keyring
    ];
  };
}
