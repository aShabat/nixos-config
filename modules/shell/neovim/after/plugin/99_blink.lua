-- [nfnl] after/plugin/99_blink.fnl
local function build_blink(params)
  if (params.spec.name == "blink.cmp") then
    vim.notify("Building blink.cmp", vim.log.levels.INFO)
    local obj
    local tgt_1_ = vim.system({"cargo", "build", "--release"}, {cwd = params.path})
    obj = (tgt_1_)[wait](tgt_1_)
    if (obj.code == 0) then
      return vim.notify("Building blink.cmp done", vim.log.levels.INFO)
    else
      return vim.notify("Building blink.cmp failed", vim.log.levels.INFO)
    end
  else
    return nil
  end
end
vim.api.nvim_create_autocmd("PackChanged", {callback = build_blink})
return vim.pack.add({{src = "https://github.com/saghen/blink.cmp"}})
