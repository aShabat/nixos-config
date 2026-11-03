-- nixpkgs:git;cargo
vim.pack.add { 'https://github.com/saghen/blink.lib', 'https://github.com/saghen/blink.cmp' }
local cmp = require 'blink.cmp'
cmp.build():pwait()

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind

    if name == 'blink.cmp' and kind ~= 'delete' then require('blink.cmp').build():pwait() end
  end,
})

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
