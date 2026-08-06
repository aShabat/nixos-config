{
  den.aspects.user-password = {
    user = {user, ...} : {
      hashedPassword = builtins.readFile (./. + "/${user.userName}.secret.passwd")
    };
  };
}
