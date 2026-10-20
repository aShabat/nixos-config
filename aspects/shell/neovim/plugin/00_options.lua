-- [nfnl] plugin/00_options.fnl
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("n", ",", "<NOP>")
do
  _G.vim.opt["number"] = true
  _G.vim.opt["relativenumber"] = true
  _G.vim.opt["splitbelow"] = true
  _G.vim.opt["splitright"] = true
  _G.vim.opt["scrolloff"] = 10
  _G.vim.opt["expandtab"] = true
  _G.vim.opt["tabstop"] = 4
  _G.vim.opt["softtabstop"] = 4
  _G.vim.opt["shiftwidth"] = 4
  _G.vim.opt["smartindent"] = true
  _G.vim.opt["autoindent"] = true
  _G.vim.opt["wrap"] = true
  _G.vim.opt["incsearch"] = true
  _G.vim.opt["hlsearch"] = true
  _G.vim.opt["inccommand"] = "split"
  _G.vim.opt["ignorecase"] = true
  _G.vim.opt["smartcase"] = true
  _G.vim.opt["undofile"] = true
  _G.vim.opt["autoread"] = true
  _G.vim.opt["swapfile"] = false
  _G.vim.opt["backup"] = false
  _G.vim.opt["termguicolors"] = true
  _G.vim.opt["signcolumn"] = "auto:9"
  _G.vim.opt["cursorline"] = true
  _G.vim.opt["colorcolumn"] = "80"
end
return {}
