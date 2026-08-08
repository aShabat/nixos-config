-- [nfnl] after/plugin/99_treesitter.fnl
vim.pack.add({{src = "https://github.com/nvim-treesitter/nvim-treesitter"}})
local _local_1_ = require("nfnl.core")
local mapcat = _local_1_.mapcat
local nvim_treesitter = require("nvim-treesitter")
nvim_treesitter.install({"nix", "lua", "fennel"}, {})
local group = vim.api.nvim_create_augroup("treesitter", {})
local languages = nvim_treesitter.get_installed()
local filetypes = mapcat(vim.treesitter.language.get_filetypes, languages)
local function _2_()
  vim.treesitter.start()
  vim.bo.indentexpr = "v:lua()require'nvim-treesitter'.indentexpr()"
  return nil
end
return vim.api.nvim_create_autocmd("FileType", {pattern = filetypes, callback = _2_, group = group})
