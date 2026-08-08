{
  den.aspects.neovim = {
    homeManager = {lib, pkgs, config, ...} : let
      concat-map-not-null = f: list: builtins.concatLists (builtins.filter (l: !(isNull l)) (builtins.map f list));
      match-lines = regex: file: concat-map-not-null (line: builtins.match regex (lib.trim line)) (lib.splitString "\n" (builtins.readFile file));
      fnl-files = builtins.filter (f: lib.hasSuffix ".fnl" (builtins.baseNameOf f)) (lib.filesystem.listFilesRecursive ./.);
      fnl-pkgs-comments = builtins.concatMap (match-lines ";nix-pkgs:(.*)") fnl-files;
      pkgs-from-comment = comment: lib.getAttrFromPath (lib.splitString "." comment) pkgs;
      fnl-pkgs = builtins.map pkgs-from-comment fnl-pkgs-comments;
      runtimeInputs = with pkgs; [];
      my-nvim = pkgs.writeShellApplication {
        name = "nvim";
	runtimeInputs = runtimeInputs ++ fnl-pkgs;
	text = ''
	  exec ${pkgs.neovim-unwrapped}/bin/nvim "$@"
	'';
      };
    in {
      home.packages = [
        my-nvim
      ];

      home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/shell/neovim";
    };
  };
}
