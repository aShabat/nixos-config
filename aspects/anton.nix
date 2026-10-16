{den, ...}: {
  includes = with den; [
    batteries.primary-user
    aspects.user-password
    aspects.shell
    aspects.keyring
    aspects.ssh
    aspects.ghostty
  ];

  user = {
    extraGroups = ["media"];
  };

  nixos = {
    users.groups.media = {};
  };
}
