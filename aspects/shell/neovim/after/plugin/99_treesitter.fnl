;nix-pkgs:gnutar:curl:tree-sitter:gcc
(vim.pack.add [{:src "https://github.com/nvim-treesitter/nvim-treesitter"}
               {:src "https://github.com/nvim-treesitter/nvim-treesitter-context"}
               {:src "https://github.com/hiphish/rainbow-delimiters.nvim"}])

(local {: mapcat} (require :nfnl.core))
(local nvim-treesitter (require :nvim-treesitter))

(nvim-treesitter.install [:nix :lua :fennel :c :vim :vimdoc :query] {})

(local group (vim.api.nvim_create_augroup :treesitter {}))
(let [languages (nvim-treesitter.get_installed)
      filetypes (mapcat vim.treesitter.language.get_filetypes languages)]
  (vim.api.nvim_create_autocmd :FileType
                               {:pattern filetypes
                                :callback (fn [] (vim.treesitter.start)
                                            (set vim.bo.indentexpr
                                                 "v:lua()require'nvim-treesitter'.indentexpr()"))
                                : group}))

((. (require :treesitter-context) :setup) {:separator "."})

(vim.keymap.set :n :gC
                (fn []
                  (let [tc (require :treesitter-context)]
                    (tc.go_to_context vim.v.count1)))
                {:silent true})

{}
