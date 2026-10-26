vim.pack.add { { src = 'https://github.com/nvim-mini/mini.nvim' } }

require('mini.extra').setup()

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require('mini.git').setup()

local MiniHipatterns = require 'mini.hipatterns'
MiniHipatterns.setup {
  highlighters = {
    fixme = { pattern = 'FIXME', group = 'MiniHiPatternsFixMe' },
    hack = { pattern = 'HACK', group = 'MiniHiPatternsHack' },
    todo = { pattern = 'TODO', group = 'MiniHiPatternsTodo' },
    note = { pattern = 'NOTE', group = 'MiniHiPatternsNote' },
    ['hex-color'] = MiniHipatterns.gen_highlighter.hex_color(),
  },
}

vim.opt.cmdheight = 0
vim.opt.showcmdloc = 'statusline'
require('mini.statusline').setup {
  content = {
    active = function()
      local msl = MiniStatusline
      local reg_recording = vim.fn.reg_recording()
      local reg_recording0
      if reg_recording ~= '' then
        reg_recording0 = ('Recording: @' .. reg_recording)
      else
        reg_recording0 = reg_recording
      end
      local mode, mode_hl = msl.section_mode { trunc_width = 120 }
      local git = msl.section_git { trunc_width = 40 }
      local diff = msl.section_diff { trunc_width = 75 }
      local diagnostics = msl.section_diagnostics { trunc_width = 75 }
      local lsp = msl.section_lsp { trunc_width = 75 }
      local filename = msl.section_filename { trunc_width = 140 }
      local fileinfo = msl.section_fileinfo { trunc_width = 120 }
      local location = msl.section_location { trunc_width = 75 }
      local search = msl.section_searchcount { trunc_width = 75 }
      local showcmd = vim.api.nvim_eval_statusline('%S', {})[str]
      return msl.combine_groups {
        { hl = 'MiniStatuslineDevinfo', strings = { reg_recording0 } },
        { hl = mode_hl, strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
        '%<',
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=',
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location } },
        { hl = 'MiniStatuslineDevinfo', strings = { showcmd } },
      }
    end,
  },
}

require('mini.trailspace').setup()

vim.api.nvim_create_user_command('MiniTrailSpace', function()
  MiniTrailspace.trim()
  MiniTrailspace.trim_last_lines()
end, {})

require('mini.notify').setup()
vim.notify = MiniNotify.make_notify {}
vim.api.nvim_create_user_command('MNHistory', function()
  do
    local editor_width = vim.o.columns
    local editor_height = vim.o.lines
    vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
      relative = 'editor',
      width = math.floor((editor_width * 0.9)),
      height = math.floor((editor_height * 0.8)),
      row = math.floor((editor_height * 0.05)),
      col = math.floor((editor_width * 0.05)),
      border = 'single',
      title = { { 'Notification History', 'MiniFilesTitle' } },
    })
  end
  MiniNotify.show_history()
  return vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<CMD>q<CR>', {})
end, {})

require('mini.move').setup {
  mappings = {
    left = 'H',
    right = 'L',
    up = 'K',
    down = 'J',
    line_left = '',
    line_right = '',
    line_up = '<C-k>',
    line_down = '<C-j>',
  },
}

require('mini.splitjoin').setup()

require('mini.ai').setup {
  custom_textobjects = { G = MiniExtra.gen_ai_spec.buffer(), L = MiniExtra.gen_ai_spec.line() },
  mappings = { around_next = '', inside_next = '' },
  search_method = 'cover',
  n_lines = math.huge,
}

require('mini.bracketed').setup { diagnostic = { option = { float = true } } }

require('mini.surround').setup()
