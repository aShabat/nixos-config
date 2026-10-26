vim.pack.add { { src = 'https://github.com/nvim-mini/mini.nvim' } }

require('mini.pick').setup {
  window = { relative = 'editor', row = 0, col = 0 },
  options = { use_cache = true },
}

vim.ui.select = MiniPick.ui_select
vim.keymap.set('n', '<Leader>ff', MiniPick.registry.files)
vim.keymap.set('n', '<Leader>fh', MiniPick.registry.help)
vim.keymap.set('n', '<Leader>fb', MiniPick.registry.buffers)
vim.keymap.set('n', '<Leader>fg', MiniPick.registry.grep_live)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    vim.keymap.set('n', 'gd', function() MiniExtra.pickers.lsp({ scope = 'definition' }, {}) end)
    vim.keymap.set('n', 'gD', function() MiniExtra.pickers.lsp({ scope = 'declaration' }, {}) end)
    vim.keymap.set(
      'n',
      '<LocalLeader>gr',
      function() MiniExtra.pickers.lsp({ scope = 'references' }, {}) end,
      { buf = ev.buf }
    )
    vim.keymap.set(
      'n',
      '<LocalLeader>gt',
      function() MiniExtra.pickers.lsp({ scope = 'type_definition' }, {}) end,
      { buf = ev.buf }
    )
    vim.keymap.set(
      'n',
      '<LocalLeader>ds',
      function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }, {}) end,
      { buf = ev.buf }
    )
    vim.keymap.set(
      'n',
      '<LocalLeader>ws',
      function() MiniExtra.pickers.lsp({ scope = 'workspace_symbol_live' }, {}) end,
      { buf = ev.buf }
    )
  end,
})
