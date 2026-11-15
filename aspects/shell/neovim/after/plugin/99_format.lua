vim.pack.add { { src = 'https://github.com/stevearc/conform.nvim' } }
local conform = require 'conform'

function formatters_by_ft_optional(opts)
  local out = {}
  for ft, formatters in pairs(opts) do
    out[ft] = function(buf)
      local formatters_available = {}
      for _, f in ipairs(formatters) do
        if conform.get_formatter_info(f, buf).available then
          formatters_available[#formatters_available + 1] = f
        end
      end
      return formatters_available
    end
  end
  return out
end

conform.setup {
  formatters_by_ft = formatters_by_ft_optional {
    nix = { 'alejandra' },
    lua = { 'stylua' },
    fish = { 'fish_indent' },
    uiua = { 'uiua' },
  },
  default_format_opts = { lsp_format = 'fallback' },
  format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
  formatters = {
    uiua = {
      command = 'uiua',
      args = { 'fmt', '--io' },
    },
  },
}

vim.api.nvim_create_user_command('Format', conform.format, {})
