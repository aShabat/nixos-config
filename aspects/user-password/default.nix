{lib, ...}: {
  user = {user, ...}: {
    hashedPassword = lib.trim (lib.fileContents (./. + "/${user.userName}.secret"));
  };

  nixos = {
    users.mutableUsers = false;
  };
}
