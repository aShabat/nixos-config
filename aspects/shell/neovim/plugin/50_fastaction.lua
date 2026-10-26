vim.pack.add {
  { src = 'https://github.com/chaitanyabsprip/fastaction.nvim' },
}

local fastaction = require 'fastaction'

fastaction.setup {}

vim.ui.select = fastaction.select

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function() vim.keymap.set('n', '<LocalLeader>ca', fastaction.code_action, { buf = 0 }) end,
})
