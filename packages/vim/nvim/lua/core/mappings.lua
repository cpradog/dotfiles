local use = require('packer').use
local global = vim.g
local option = vim.o
local cmd = vim.cmd
local keymap = vim.api.nvim_set_keymap

-- leader key
global.mapleader = ','
global.maplocalleader = '.'

-- discard keystroke if not completed in a sort time (milliseconds)
option.timeout = true
option.timeoutlen = 1000
--
-- milliseconds for cursorhold to trigger
option.updatetime = 300

-- disable recording
keymap('n', 'q', '<Nop>', { noremap = true, silent = true })
keymap('n', 'Q', '<Nop>', { noremap = true, silent = true })

-- maintain selection on indentation
keymap('v', '>', '>gv', { silent = true })
keymap('v', '<', '<gv', { silent = true })

-- buffer navigation
keymap('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
keymap('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })

-- window navigation
keymap('n', '<C-h>', '<C-W>h', { noremap = true, silent = true })
keymap('n', '<C-j>', '<C-W>j', { noremap = true, silent = true })
keymap('n', '<C-k>', '<C-W>k', { noremap = true, silent = true })
keymap('n', '<C-l>', '<C-W>l', { noremap = true, silent = true })

-- standard Ctrl+Z undo
keymap('i', '<C-z>', '<esc>ui', { noremap = true, silent = true })
keymap('n', '<C-z>', '<Nop>', { noremap = true, silent = true })

-- fix common typos
cmd [[
  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Qall qall
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
]]

-- close help and man windows
cmd [[
  augroup close_help
    autocmd!
    autocmd FileType help nnoremap <buffer> q <cmd>close<CR>
  augroup END
]]

use {
  'folke/which-key.nvim',
  config = function()
    require('which-key').setup()
  end,
}
