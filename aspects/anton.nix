{den, ...}: {
  includes = with den; [
    batteries.primary-user
    aspects.user-password
    aspects.shell
    aspects.keyring
    aspects.ssh
    aspects.desktop.ghostty
  ];

  user = {
    extraGroups = ["media"];
  };

  nixos = {
    users.groups.media = {};
  };
}
