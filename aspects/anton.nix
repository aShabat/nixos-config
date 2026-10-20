{den, ...}: {
  includes = with den; [
    batteries.primary-user
    aspects.ssh
  ];

  user = {
    extraGroups = ["media"];
  };

  nixos = {
    users.groups.media = {};
  };
}
