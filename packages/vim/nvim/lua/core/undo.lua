local use = require('packer').use

use {
  'simnalamburt/vim-mundo',
  config = function()
    vim.g.mundo_right = 1
    vim.g.mundo_preview_bottom = 1
    vim.g.mundo_preview_height = 30
    vim.g.mundo_width = 40
    vim.g.mundo_close_on_revert = 1

    vim.api.nvim_set_keymap(
      'n', 'U', ':MundoToggle<CR>', { noremap = true, silent = true }
    )
  end,
}
