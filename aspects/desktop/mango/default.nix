{
  inputs,
  aspect-utils,
  ...
}: {
  flake-file.inputs.mangowm = {
    url = "github:mangowm/mango";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  nixos = {
    imports = [inputs.mangowm.nixosModules.mango];
    programs.mango.enable = true;
  };

  provides.to-users.includes = [aspect-utils.self];
}
