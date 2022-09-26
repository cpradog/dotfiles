local use = require('packer').use

use {
  'cpradog/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    vim.g.nvim_tree_auto_close = 1
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_highlight_opened_files = 1
    vim.g.nvim_tree_auto_resize = 1
    vim.g.nvim_tree_clear_buffer_command = ':BufDel!'
    vim.g.nvim_tree_lsp_diagnostics = true
    vim.api.nvim_set_keymap(
      '', '<F10>', ':NvimTreeToggle<CR>', { noremap = true, silent = true }
    )
  end,
}

use 'tpope/vim-eunuch'

use {
  'jghauser/mkdir.nvim',
  config = function()
    require('mkdir')
  end,
}
