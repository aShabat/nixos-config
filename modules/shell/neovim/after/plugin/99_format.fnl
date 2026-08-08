(vim.pack.add [{
              :src "https://github.com/stevearc/conform.nvim" 
               }])

(let [conform (require "conform")
      opts {
        :formatters_fy_ft {
            ;nix-pkgs:fnlfmt
            :fennel { "fnlfmt" }
        }
      }]
  (conform.setup opts)

  (vim.api.nvim_create_user_command "Format" conform.format {}))
