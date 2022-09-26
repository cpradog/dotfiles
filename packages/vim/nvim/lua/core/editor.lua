local option = vim.o
local use = require('packer').use

-- integrate clipboard
option.clipboard = 'unnamed,unnamedplus'

-- modern editor backspace
option.backspace = 'indent,eol,start'

-- disable concealing
option.conceallevel = 0

-- disable folding
option.foldenable = false

-- enable line numbers relative to current line
option.number = true
option.relativenumber = true

-- stop jumping on scrolling but keep a few lines of context
option.scrolljump = 0
option.scrolloff = 3

-- allow for cursor beyond last character
option.virtualedit = 'onemore'

-- do not wrap long lines
option.wrap = false

-- allow backspace and cursor keys to wrap
option.whichwrap = 'b,s,h,l,<,>,[,]'

-- highlight current line
option.cursorline = true

-- highlight matching pairs
option.showmatch = true

-- always show sign column
option.signcolumn = 'yes'

-- enable mouse support
option.mouse = 'a'

-- multiple cursors
use 'terryma/vim-multiple-cursors'
