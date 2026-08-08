{
  den.aspects.neovim = {
    homeManager = {pkgs, config, ...} : let
      utils = with pkgs; [];
      languages = with pkgs; [];
      language-servers = with pkgs; [];
      formatters = with pkgs; [];
      my-nvim = pkgs.writeShellApplication {
        name = "nvim";
	runtimeInputs = utils ++ languages ++ language-servers ++ formatters;
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
