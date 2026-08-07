{
  den.aspects.neovim = {
    homeManager = {pkgs, config, ...} : {
      home.packages = with pkgs; [
        neovim-unwrapped
      ];

      home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/shell/neovim";
    };
  };
}
