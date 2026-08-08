-- [nfnl] after/plugin/99_format.fnl
vim.pack.add({{src = "https://github.com/stevearc/conform.nvim"}})
local conform = require("conform")
local opts = {}
conform.setup(opts)
return vim.api.nvim_create_user_command("Format", conform.format, {})
