{lib, ...} : {
  den.aspects.user-password = {
    user = {user, ...} : {
      hashedPassword = lib.trim (builtins.readFile (./. + "/${user.userName}.secret.passwd"));
    };
  };
}
