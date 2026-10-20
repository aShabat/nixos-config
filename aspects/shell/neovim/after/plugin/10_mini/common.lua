-- [nfnl] after/plugin/10_mini/common.fnl
vim.pack.add({{src = "https://github.com/nvim-mini/mini.nvim"}})
do
  local package_2_auto = require("mini.extra")
  package_2_auto.setup()
end
do
  local package_2_auto = require("mini.icons")
  package_2_auto.setup()
end
MiniIcons.mock_nvim_web_devicons()
do
  local package_2_auto = require("mini.git")
  package_2_auto.setup()
end
do
  local package_2_auto = require("mini.hipatterns")
  package_2_auto.setup()
end
do
  local package_2_auto = require("mini.hipatterns")
  package_2_auto.setup({highlighters = {fixme = {pattern = "FIXME", group = "MiniHiPatternsFixMe"}, hack = {pattern = "HACK", group = "MiniHiPatternsHack"}, todo = {pattern = "TODO", group = "MiniHiPatternsTodo"}, note = {pattern = "NOTE", group = "MiniHiPatternsNote"}, ["hex-color"] = MiniHipatterns.gen_highlighter.hex_color()}})
end
vim.opt.cmdheight = 0
vim.opt.showcmdloc = "statusline"
do
  local active_content
  local function _1_()
    local msl = MiniStatusline
    local reg_recording = vim.fn.reg_recording()
    local reg_recording0
    if (reg_recording ~= "") then
      reg_recording0 = ("Recording: @" .. reg_recording)
    else
      reg_recording0 = reg_recording
    end
    local mode,mode_hl = msl.section_mode({trunc_width = 120})
    local git = msl.section_git({trunc_width = 40})
    local diff = msl.section_diff({trunc_width = 75})
    local diagnostics = msl.section_diagnostics({trunc_width = 75})
    local lsp = msl.section_lsp({trunc_width = 75})
    local filename = msl.section_filename({trunc_width = 140})
    local fileinfo = msl.section_fileinfo({trunc_width = 120})
    local location = msl.section_location({trunc_width = 75})
    local search = msl.section_searchcount({trunc_width = 75})
    local showcmd = vim.api.nvim_eval_statusline("%S", {})[str]
    return msl.combine_groups({{hl = "MiniStatuslineDevinfo", strings = {reg_recording0}}, {hl = mode_hl, strings = {mode}}, {hl = "MiniStatuslineDevinfo", strings = {git, diff, diagnostics, lsp}}, "%<", {hl = "MiniStatuslineFilename", strings = {filename}}, "%=", {hl = "MiniStatuslineFileinfo", strings = {fileinfo}}, {hl = mode_hl, strings = {search, location}}, {hl = "MiniStatuslineDevinfo", strings = {showcmd}}})
  end
  active_content = _1_
  local package_2_auto = require("mini.statusline")
  package_2_auto.setup({content = {active = active_content}})
end
do
  local package_2_auto = require("mini.trailspace")
  package_2_auto.setup()
end
do
  local package_2_auto = require("mini.notify")
  package_2_auto.setup({window = {max_width_share = 0.7}})
end
vim.notify = MiniNotify.make_notify({})
local function _3_()
  do
    local editor_width = vim.o.columns
    local editor_height = vim.o.lines
    vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {relative = "editor", width = math.floor((editor_width * 0.9)), height = math.floor((editor_height * 0.8)), row = math.floor((editor_height * 0.05)), col = math.floor((editor_width * 0.05)), border = "single", title = {{"Notification History", "MiniFilesTitle"}}})
  end
  MiniNotify.show_history()
  return vim.api.nvim_buf_set_keymap(0, "n", "q", "<CMD>q<CR>", {})
end
vim.api.nvim_create_user_command("MNHistory", _3_, {})
do
  local package_2_auto = require("mini.move")
  package_2_auto.setup({mappings = {left = "H", right = "L", up = "K", down = "J", line_left = "", line_right = "", line_up = "<C-k>", ["line-down"] = "<C-j>"}})
end
do
  local package_2_auto = require("mini.splitjoin")
  package_2_auto.setup()
end
do
  local package_2_auto = require("mini.ai")
  package_2_auto.setup({custom_textobjects = {G = MiniExtra.gen_ai_spec.buffer(), L = MiniExtra.gen_ai_spec.line()}, mappings = {around_next = "", inside_next = ""}, search_method = "cover", n_lines = math.huge})
end
do
  local package_2_auto = require("mini.bracketed")
  package_2_auto.setup({diagnostic = {option = {float = true}}})
end
do
  local package_2_auto = require("mini.surround")
  package_2_auto.setup()
end
return {}
