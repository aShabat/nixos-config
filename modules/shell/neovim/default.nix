{
  den.aspects.neovim = {
    homeManager = {lib, pkgs, config, ...} : let
      concat-map-not-null = f: list: builtins.concatLists (builtins.filter (l: !(isNull l)) (builtins.map f list));
      match-lines = regex: file: concat-map-not-null (line: builtins.match regex (lib.trim line)) (lib.splitString "\n" (builtins.readFile file));
      fnl-files = builtins.filter (f: lib.hasSuffix ".fnl" (builtins.baseNameOf f)) (lib.filesystem.listFilesRecursive ./.);
      fnl-pkg-comments = builtins.concatMap (match-lines ";nix-pkgs: (.*)") fnl-files;
      fnl-pkgs = builtins.map (p: pkgs.${p}) fnl-pkg-comments;
      utils = with pkgs; [
        git
	curl
        ripgrep
      ];
      languages = with pkgs; [
        luajitPackages.fennel
      ];
      language-servers = with pkgs; [];
      formatters = with pkgs; [];
      my-nvim = pkgs.writeShellApplication {
        name = "nvim";
	runtimeInputs = utils ++ languages ++ language-servers ++ formatters ++ fnl-pkgs;
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
