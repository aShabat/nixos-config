-- nixpkgs:git
vim.pack.add { 'https://github.com/saghen/blink.lib', 'https://github.com/saghen/blink.cmp' }
local cmp = require 'blink.cmp'
cmp.build():pwait()

cmp.setup {
  cmdline = { completion = { menu = { auto_show = true } }, keymap = { preset = 'default' } },
  completion = {
    keyword = { range = 'full' },
    trigger = { show_on_backspace = true },
    documentation = { auto_show = true },
  },
  keymap = {
    preset = 'default',
    ['<Tab>'] = false,
    ['<S-Tab>'] = false,

    ['<C-l>'] = { 'snippet_forward' },
    ['<C-k>'] = { 'snippet_backward' },
  },
  signature = {
    enabled = true,
    trigger = {
      enabled = true,
    },
  },
  sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
}
