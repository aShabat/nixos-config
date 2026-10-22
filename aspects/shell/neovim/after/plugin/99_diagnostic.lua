vim.diagnostic.config {
  signs = false,
  float = {
    scope = 'line',
    severity = { min = vim.diagnostic.severity.INFO },
    severity_sort = true,
  },
  jump = {
    on_jump = vim.diagnostic.open_float,
    severity = { min = vim.diagnostic.severity.WARN },
  },
  virtual_lines = {
    current_line = true,
    severity = { min = vim.diagnostic.severity.INFO },
  },
  virtual_text = {
    current_line = false,
    severity = { min = vim.diagnostic.severity.INFO },
    format = function(diagnostic) return '' end,
    virt_text_pos = 'eol',
  },
}

vim.keymap.set('n', '<LocalLeader>D', vim.diagnostic.open_float)
