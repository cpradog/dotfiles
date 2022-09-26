local option = vim.o
local use = require('packer').use

-- disable backup files
option.backup = false

-- disable swap files
option.swapfile = false

-- override files instead of replacing them
option.backupcopy = 'yes'

-- reload file changes
option.autoread = true

-- allow switch buffers with unsaved changes
option.hidden = true

-- allow a ton of history
option.history = 1000

-- alow ton of undo
option.undolevels = 1000

-- retain window layout on buffer close
use {
  'ojroques/nvim-bufdel',
  config = function()
    require('bufdel').setup({ next = 'cycle', quit = false })

    vim.api.nvim_set_keymap(
      'n', '<leader>w', ':BufDel<CR>', { noremap = true, silent = true }
    )
  end,
}
