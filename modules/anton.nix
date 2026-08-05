{den, ...} : {
  den.aspects.anton = {
    includes = with den; [ 
      batteries.primary-user 
      aspects.shell
      aspects.keyring
      ];

    user = {
      password = "nixospass";
    };
  };
}
