-- [nfnl] after/plugin/10_mini/pick.fnl
vim.pack.add({{src = "https://github.com/nvim-mini/mini.nvim"}})
do
  local MiniPick = require("mini.pick")
  MiniPick.setup({window = {relative = "editor", row = 0, col = 0}, options = {use_cache = true}})
end
vim.ui.select = MiniPick.ui_select
vim.keymap.set("n", "<Leader>ff", MiniPick.registry.files)
vim.keymap.set("n", "<Leader>fh", MiniPick.registry.help)
vim.keymap.set("n", "<Leader>fb", MiniPick.registry.buffers)
return vim.keymap.set("n", "<Leader>fg", MiniPick.registry.grep_live)
