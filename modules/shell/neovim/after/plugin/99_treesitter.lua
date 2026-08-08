-- [nfnl] after/plugin/99_treesitter.fnl
vim.pack.add({{src = "https://github.com/nvim-treesitter/nvim-treesitter"}})
local nvim_treesitter = require("nvim-treesitter")
return nvim_treesitter.install({"nix", "lua", "fennel"}, {summary = true})
