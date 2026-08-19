-- [nfnl] after/ftplugin/fennel.fnl
vim.keymap.set("n", "<LocalLeader><LocalLeader>", "<CMD>NfnlFile<CR>", {buf = 0})
vim.lsp.enable("fennel-ls")
return {}
