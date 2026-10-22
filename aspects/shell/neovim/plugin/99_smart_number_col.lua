vim.opt.number = true
vim.opt.relativenumber = true

local function status_column_smart_number()
  if !vim.wo.number then return '' end
  local lnum = tonumber(vim.v.lnum)
  if vim.g.actual_curwin ~= tostring(vim.api.nvim_get_current_win()) then return lnum end
  if vim.fn.mode(0) == 'i' or vim.fn.mode(0) == 'R' then return lnum end

  local relnum = tonumber(vim.v.relnum)
  if relnum == 5 or relnum % 10 == 0 and relnum ~= 0 then return '%#CursorLineNr#' .. relnum .. '%*' end
  return lnum
end

_G.number = status_column_smart_number
vim.wo.statuscolumn = '%C%s%{%v:lua.number()%}'
