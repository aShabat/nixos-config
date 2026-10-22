{lib, ...}: {
  homeManager = {
    pkgs,
    config,
    ...
  }: let
    concat-map-not-null = f: list: lib.concatLists (lib.filter (l: l != null) (lib.map f list));
    match-lines = regex: file:
      concat-map-not-null (line: lib.match regex (lib.trim line)) (
        lib.splitString "\n" (lib.readFile file)
      );
    lua-files = lib.filter (f: lib.hasSuffix ".lua" (lib.baseNameOf f)) (
      lib.filesystem.listFilesRecursive ./.
    );
    lua-pkgs-comments = lib.concatMap (match-lines ".*-- nix-pkgs:(.*)") lua-files;
    lua-pkgs-split = lib.concatMap (lib.splitString ":") lua-pkgs-comments;
    pkgs-from-comment = comment: lib.getAttrFromPath (lib.splitString "." comment) pkgs;
    lua-pkgs = lib.map pkgs-from-comment lua-pkgs-comments;
    fnl-files = lib.filter (f: lib.hasSuffix ".fnl" (lib.baseNameOf f)) (
      lib.filesystem.listFilesRecursive ./.
    );
    fnl-pkgs-comments = lib.concatMap (match-lines ".*;nix-pkgs:(.*)") fnl-files;
    fnl-pkgs-split = lib.concatMap (lib.splitString ":") fnl-pkgs-comments;
    fnl-pkgs = lib.map pkgs-from-comment fnl-pkgs-split;
    runtimeInputs = with pkgs; [];
    my-nvim = pkgs.writeShellApplication {
      name = "nvim";
      runtimeInputs = runtimeInputs ++ fnl-pkgs ++ lua-pkgs;
      text = ''
        exec ${pkgs.neovim-unwrapped}/bin/nvim "$@"
      '';
    };
  in {
    home.packages = [my-nvim];

    home.file.".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/aspects/shell/neovim";

    home.activation.syncVimPack = config.lib.dag.entryAfter ["writeBoundary"] ''
      ${my-nvim}/bin/nvim --headless '+lua vim.pack.update({}, { target = "lockfile", force = true })' +qa
    '';
  };

  persist.home.directories = [
    ".local/state/nvim"
    ".local/share/nvim"
  ];
}
