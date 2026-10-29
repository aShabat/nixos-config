vim.pack.add {
  { src = 'https://github.com/OXY2DEV/markview.nvim' },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
}

require('mini.icons').setup()
require('nvim-treesitter').install {
  'markdown',
  'markdown_inline',
  'html',
  'latex',
  'typst',
  'yaml',
  'comment',
}

require('markview').setup {
  preview = {
    icon_provider = 'mini',
  },
}
