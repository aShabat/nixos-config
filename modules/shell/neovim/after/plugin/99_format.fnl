(vim.pack.add [{:src "https://github.com/stevearc/conform.nvim"}])

(let [conform (require :conform)
      opts {:formatters_by_ft {;nix-pkgs:fnlfmt
                               :fennel [:fnlfmt]
                               ;nix-pkgs:alejandra
                               :nix [:alejandra]}
            :default_format_opts {:lsp_format :fallback}
            :format_on_save {:timeout_ms 500 :lsp_format :fallback}}]
  (conform.setup opts)
  (vim.api.nvim_create_user_command :Format conform.format {}))

{}
