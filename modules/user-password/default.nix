{lib, ...}: {
  den.aspects.user-password = {
    user = {user, ...}: {
      hashedPasswordFile = builtins.toString (./. + "/${user.userName}.secret");
    };
  };
}
