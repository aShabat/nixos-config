-- [nfnl] after/plugin/99_leap.fnl
vim.pack.add({{src = "https://codeberg.org/andyg/leap.nvim"}})
local group = vim.api.nvim_create_augroup("user-leap", {})
local leap = require("leap")
leap.opts.safe_labels = "fnut/SFNLHMUGTZ?"
vim.keymap.set({"n", "v"}, "f", "<Plug>(leap)")
vim.keymap.set("n", "F", "<Plug>(leap-from-window)")
vim.keymap.set({"n", "o"}, "gf", "<Plug>(leap-visit)")
vim.keymap.set({"n", "o"}, "gF", "<Plug>(leap-visit-linewise)")
vim.keymap.set({"x", "o"}, "ar", "<Plug>(leap-visit-text-object)")
vim.keymap.set({"x", "o"}, "ir", "<Plug>(leap-visit-inner-text-object)")
vim.keymap.set("o", "rr", "<Plug>(leap-visit-line)")
local function _1_()
  local lt = require("leap.treesitter")
  return lt.select({opts = require("leap.user").with_traversal_keys("n", "N")})
end
vim.keymap.set({"x", "o"}, "an", _1_)
return {}
