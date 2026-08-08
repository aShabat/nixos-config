-- [nfnl] after/plugin/99_mini.fnl
vim.pack.add({{src = "https://github.com/nvim-mini/mini.nvim"}})
local function setup(package, _3fopts)
  local required = require(package)
  return required.setup((opts or {}))
end
setup("mini.extra")
setup("mini.icons")
MiniIcons.mock_nvim_web_devicons()
setup("mini.git")
setup("mini.hipatterns")
setup("mini.hipatterns", {highlighters = {fixme = {pattern = "FIXME", group = "MiniHiPatternsFixMe"}, hack = {pattern = "HACK", group = "MiniHiPatternsHack"}, todo = {pattern = "TODO", group = "MiniHiPatternsTodo"}, note = {pattern = "NOTE", group = "MiniHiPatternsNote"}, ["hex-color"] = MiniHipatterns.gen_highlighter.hex_color()}})
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
  setup("mini.statusline", {content = {active = active_content}})
end
setup("mini.trailspace")
setup("mini.notify", {window = {max_width_share = 0.7}})
vim.notify = MiniNotify.make_notify({})
local function _3_()
  MiniNotify.show_history()
  return vim.api.nvim_buf_keymap_set(0, "n", "q", "<CMD>q<CR>")
end
vim.api.nvim_create_user_command("MNHistory", _3_)
setup("mini.move", {mappings = {left = "H", right = "L", up = "K", down = "J", line_left = "", line_right = "", line_up = "<C-k>", ["line-down"] = "<C-j>"}})
setup("mini.splitjoin")
setup("mini.ai", {custom_textobjects = {G = MiniExtra.gen_ai_spec.buffer(), L = MiniExtra.gen_ai_spec.line()}, search_method = "cover", n_lines = math.huge})
setup("mini.bracketed", {diagnostic = {option = {float = true}}})
setup("mini.surround")
return {}
