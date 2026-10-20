;nix-pkgs:cargo
(vim.pack.add ["https://github.com/saghen/blink.lib"
               "https://github.com/saghen/blink.cmp"])

(local cmp (require :blink.cmp))
(: (cmp.build) :pwait)

(cmp.setup {:cmdline {}
            :completion {:keyword {:range :full}
                         :trigger {:show_on_backspace true}
                         :accept {:auto_brackets {:enabled false}}
                         :documentation {:auto_show true}}
            :sources {:default [:lsp :path :snippets :buffer]}})

{}
