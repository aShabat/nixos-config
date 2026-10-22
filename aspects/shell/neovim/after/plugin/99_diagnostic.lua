vim.diagnostic.config {
  float = {
    scope = 'line',
    severity = { min = vim.diagnostic.severity.INFO },
    severity_sort = true,
  },
  jump = {
    on_jump = vim.diagnostic.open_float,
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = {
    severity = { min = vim.diagnostic.severity.INFO },
  },
  virtual_lines = {
    current_line = true,
    severity = { min = vim.diagnostic.severity.INFO },
  },
  virtual_text = {
    current_line = false,
    severity = { min = vim.diagnostic.severity.INFO },
    virt_text_pos = 'eol',
  },
}

vim.keymap.set('n', '<LocalLeader>D', vim.diagnostic.open_float)
