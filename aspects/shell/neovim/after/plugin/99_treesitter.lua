vim.pack.add({{src = "https://github.com/nvim-treesitter/nvim-treesitter"}, {src = "https://github.com/nvim-treesitter/nvim-treesitter-context"}, {src = "https://github.com/hiphish/rainbow-delimiters.nvim"}})
local nvim_treesitter = require("nvim-treesitter")

nvim_treesitter.install({"nix", "lua", "fennel", "c", "vim", "vimdoc", "query"}, {})

local group = vim.api.nvim_create_augroup("treesitter", {})

local filetypes={}
for _, language in ipairs(nvim_treesitter.get_installed()) do
  for _, filetype in ipairs(vim.treesitter.language.get_filetypes(language)) do
      filetypes[#filetypes + 1] = filetype
  end
end

vim.api.nvim_create_autocmd("FileType", {pattern = filetypes, callback = function ()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua()require'nvim-treesitter'.indentexpr()"
    return nil
  end
, group = group})

require("treesitter-context").setup({separator = "."})

vim.keymap.set("n", "gC", function ()
  local tc = require("treesitter-context")
  return tc.go_to_context(vim.v.count1)
end
, {silent = true})
