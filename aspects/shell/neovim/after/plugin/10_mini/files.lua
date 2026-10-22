vim.pack.add { { src = 'https://github.com/nvim-mini/mini.nvim' } }
local H = {}
local group = vim.api.nvim_create_augroup('user-minifiles', {})

local function basename(path) return vim.fn.fnamemodify(path, ':h') end
local function filename(path) return vim.fn.fnamemodify(path, ':t') end
H['show-all'] = false
H['toggle-show'] = function()
  H['show-all'] = not H['show-all']
  return MiniFiles.refresh(MiniFiles.config)
end
-- nixpkgs:fd
H['filter-fd'] = function(fs_entry)
  local process =
    vim.system { 'fd', '-q', '-g', filename(fs_entry.path), '-C', basename(fs_entry.path) }
  local status = process:wait(1000).code
  return (status == 0)
end
H['filter-strict'] = function(fs_entry) return not vim.startswith(fs_entry.name, '.') end
H.filter = function(fs_entry)
  if H['show-all'] then
    return true
  else
    return H['filter-fd'](fs_entry)
  end
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  group = group,
  callback = function(args)
    vim.keymap.set('n', 'g.', H['toggle-show'], { buffer = args.data.buf_id })
    return print 'test'
  end,
})

require('mini.files').setup {
  options = { use_as_default_explorer = true },
  content = { filter = H.filter },
  windows = { width_preview = 100 },
  mappings = { go_in = 'L', go_in_plus = 'l' },
}

vim.keymap.set('n', '<leader>e', function()
  local path = vim.api.nvim_buf_get_name(0)
  local path0 = vim.fs.normalize(path)
  local path1
  if vim.fn.filereadable(path0) == 0 then
    local path2 = vim.fs.dirname(path0)
    if vim.fn.isdirectory(path2) == 0 then
      path1 = vim.fn.getcwd()
    else
      path1 = path2
    end
  else
    path1 = path0
  end
  MiniFiles.open(path1, false)
  return MiniFiles.trim_right()
end)
