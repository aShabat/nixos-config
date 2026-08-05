{den, ...} : {
  den.aspects.anton = {
    includes = [ den.batteries.primary-user 
      den.aspects.shell
      ];

    user = {
      password = "nixospass";
    };
  };
}
