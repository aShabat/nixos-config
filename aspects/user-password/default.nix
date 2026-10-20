{lib, ...}: {
  user = {user, ...}: {
    hashedPasswordFile = lib.toString (./. + "/${user.userName}.secret");
  };
}
