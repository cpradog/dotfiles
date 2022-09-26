local option = vim.o
local use = require('packer').use

-- disable redraw while executing macros
option.lazyredraw = true

-- ask for confirmation on unsaved changes
option.confirm = true

-- do not ask for confirmation if no pending changes
use {
  'vim-scripts/confirm-quit',
  config = function()
    vim.g.confirm_quit_nomap = 1
    vim.api.nvim_set_keymap(
      'c', 'wq<CR>', ':call confirm_quit#confirm(1, \'last\')<CR>',
      { noremap = true, silent = true }
    )
  end,
}

