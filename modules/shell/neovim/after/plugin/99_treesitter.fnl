;nix-pkgs:gnutar
;nix-pkgs:curl
;nix-pkgs:tree-sitter
;nix-pkgs:gcc
(vim.pack.add [{:src "https://github.com/nvim-treesitter/nvim-treesitter"}])
(local {: mapcat} (require :nfnl.core))
(local nvim-treesitter (require :nvim-treesitter))

(nvim-treesitter.install [:nix :lua :fennel] {})

(local group (vim.api.nvim_create_augroup :treesitter {}))
(let [languages (nvim-treesitter.get_installed)
      filetypes (mapcat vim.treesitter.language.get_filetypes languages)]
  (vim.api.nvim_create_autocmd :FileType
                               {:pattern filetypes
                                :callback (fn [] (vim.treesitter.start))
                                : group}))
