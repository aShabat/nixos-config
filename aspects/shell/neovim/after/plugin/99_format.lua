vim.pack.add { { src = 'https://github.com/stevearc/conform.nvim' } }
local conform = require 'conform'

conform.setup {
  formatters_by_ft = { nix = { 'alejandra' }, lua = { 'stylua' } },
  default_format_opts = { lsp_format = 'fallback' },
  format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
}

vim.api.nvim_create_user_command('Format', conform.format, {})
