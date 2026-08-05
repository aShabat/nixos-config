{den, ...} : {
  den.aspects.shell = {
    includes = with den.aspects; [
      git
    ];
  };
}
