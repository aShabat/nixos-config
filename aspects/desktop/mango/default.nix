{
  inputs,
  aspect-utils,
  ...
}: {
  flake-file.inputs.mangowm = {
    url = "github:mangowm/mango";
    inputs = {
      flake-parts.follows = "flake-parts";
      nixpkgs.follows = "nixpkgs";
    };
  };

  nixos = {
    imports = [inputs.mangowm.nixosModules.mango];
    programs.mango.enable = true;
  };

  homeManager = {
    pkgs,
    config,
    host,
    ...
  }: {
    home.packages = with pkgs; [noctalia];
    home.file.".config/mango".source = config.lib.file.mkOutOfStoreSymlink ("/etc/nixos/aspects/desktop/mango/configs/" + host.hostName);
    home.file.".config/mango-common".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/aspects/desktop/mango/configs/common";
  };

  provides.to-users.includes = [aspect-utils.self];
}
