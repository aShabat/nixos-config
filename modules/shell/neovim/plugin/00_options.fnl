(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")
(vim.keymap.set "n" "," "<NOP>")

(macro set-opts [name value & rest]
  `(do (tset _G.vim.opt ,name ,value) 
     ,(when (> (length rest) 0) `(set-opts ,(unpack rest)))))

(set-opts
  :number true
  :relativenumber true

  :splitbelow true
  :splitright true

  :scrolloff 10

  :expandtab true
  :tabstop 4
  :softtabstop 4
  :shiftwidth 4
  :smartindent true
  :autoindent true

  :wrap true
  
  :incsearch true
  :hlsearch true
  :inccommand "split"

  :ignorecase true
  :smartcase true

  :undofile true
  :autoread true
  :swapfile false
  :backup false

  :termguicolors true

  :signcolumn "auto:9"

  :cursorline true

  :colorcolumn "80")


{}

