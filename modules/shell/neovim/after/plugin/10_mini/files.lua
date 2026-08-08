-- [nfnl] after/plugin/10_mini/files.fnl
local H = {}
local function toggle_show()
  H["show-all"] = not H["show-all"]
  return MiniFiles.refresh(MiniFiles.config)
end
local function filter_strict(fs_entry)
  return not vim.startswith(fs_entry.name, ".")
end
local function filter(fs_entry)
  if H["show-all"] then
    return true
  else
    return filter_strict(fs_entry)
  end
end
local group = vim.api.nvim_create_augroup("minifiles", {})
local function _2_(args)
  vim.keymap.set("n", "g.", toggle_show, {buffer = args.data.buf_id})
  return print("test")
end
vim.api.nvim_create_autocmd("User", {pattern = "MiniFilesBufferCreate", callback = _2_, group = group})
do
  local mf = require("mini.files")
  mf.setup({options = {use_as_default_explorer = true}, content = {filter = filter}, windows = {width_preview = 100}, mappings = {go_in = "L", go_in_plus = "l"}})
end
do
  local file_explorer
  local function _3_()
    H["show-all"] = false
    local path = vim.api.nvim_buf_get_name(0)
    local path0 = vim.fs.normalize(path)
    local path1
    if (vim.fn.filereadable(path0) == 0) then
      local path2 = vim.fs.dirname(path0)
      if (vim.fn.isdirectory(path2) == 0) then
        path1 = vim.fn.getcwd()
      else
        path1 = path2
      end
    else
      path1 = path0
    end
    MiniFiles.open(path1, false)
    return MiniFiles.trim_right()
  end
  file_explorer = _3_
  vim.keymap.set("n", "<leader>e", file_explorer)
end
return {}
