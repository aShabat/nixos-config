-- [nfnl] after/plugin/99_format.fnl
vim.pack.add({{src = "https://github.com/stevearc/conform.nvim"}})
do
  local conform = require("conform")
  local opts = {formatters_by_ft = {fennel = {"fnlfmt"}, nix = {"alejandra"}}, default_format_opts = {lsp_format = "fallback"}, format_on_save = {timeout_ms = 500, lsp_format = "fallback"}}
  conform.setup(opts)
  vim.api.nvim_create_user_command("Format", conform.format, {})
end
return {}
