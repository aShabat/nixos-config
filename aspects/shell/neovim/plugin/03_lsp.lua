vim.pack.add { { src = 'https://github.com/neovim/nvim-lspconfig' } }

for _, file in ipairs(vim.fn.readdir '/etc/nixos/aspects/shell/neovim/lsp') do
  local name = file:sub(1, file:find '%.lua' - 1)
  vim.lsp.enable(name)
end
