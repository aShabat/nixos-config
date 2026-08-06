{den, ...} : {
  den.aspects.anton = {
    includes = with den; [ 
      batteries.primary-user 
      aspects.user-password
      aspects.shell
      aspects.keyring
      aspects.ssh
      ];
  };
}
