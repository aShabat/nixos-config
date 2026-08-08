;nix-pkgs:tar
;nix-pkgs:curl
;nix-pkgs:tree-sitter
;nix-pkgs:cc
(vim.pack.add [{:src "https://github.com/nvim-treesitter/nvim-treesitter"}])
(local nvim-treesitter (require :nvim-treesitter))

(nvim-treesitter.install [:nix :lua :fennel] {:summary true})
