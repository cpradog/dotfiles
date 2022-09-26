local use = require('packer').use

vim.env.GIT_EDITOR = 'nvr -cc split --remote-wait'

use { 'tpope/vim-fugitive' }

use {
  'rhysd/committia.vim',
  config = function()
    vim.g.committia_open_only_vim_starting = 0
    vim.g.committia_edit_window_width = 120
  end,
}

use {
  'lewis6991/gitsigns.nvim',
  requires = { 'plenary.nvim' },
  config = function()
    require('gitsigns').setup(
      {
        current_line_blame = true,
        current_line_blame_opts = { delay = 100 },
        current_line_blame_formatter_opts = { relative_time = true },
      }
    )
  end,
}
