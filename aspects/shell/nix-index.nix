{inputs, ...}: {
  homeManager = {
    imports = [inputs.nix-index-database.homeModules.default];
    programs.nix-index-database.comma.enable = true;
  };

  persist.home.directories = [".local/state/comma"];
}
