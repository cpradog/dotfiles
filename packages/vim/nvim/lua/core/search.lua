local option = vim.o
local use = require('packer').use

-- highlight search matches
option.hlsearch = true

-- case insensitive search
option.ignorecase = true
option.smartcase = true

-- show matches on typing
option.incsearch = true

-- replace preview
option.inccommand = 'nosplit'

use 'haya14busa/is.vim'
