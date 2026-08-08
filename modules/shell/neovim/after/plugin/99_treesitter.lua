-- [nfnl] after/plugin/99_treesitter.fnl
vim.pack.add({{src = "https://github.com/nvim-treesitter/nvim-treesitter"}, {src = "https://github.com/nvim-treesitter/nvim-treesitter-context"}, {src = "https://github.com/hiphish/rainbow-delimiters.nvim"}})
local _local_1_ = require("nfnl.core")
local mapcat = _local_1_.mapcat
local nvim_treesitter = require("nvim-treesitter")
nvim_treesitter.install({"nix", "lua", "fennel", "c", "vim", "vimdoc", "query"}, {})
local group = vim.api.nvim_create_augroup("treesitter", {})
do
  local languages = nvim_treesitter.get_installed()
  local filetypes = mapcat(vim.treesitter.language.get_filetypes, languages)
  local function _2_()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua()require'nvim-treesitter'.indentexpr()"
    return nil
  end
  vim.api.nvim_create_autocmd("FileType", {pattern = filetypes, callback = _2_, group = group})
end
require("treesitter-context").setup({separator = "."})
local function _3_()
  local tc = require("treesitter-context")
  return tc.go_to_context(vim.v.count1)
end
vim.keymap.set("n", "gC", _3_, {silent = true})
return {}
