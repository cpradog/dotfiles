local use = require('packer').use

use 'jxnblk/vim-mdx-js'
use 'godlygeek/tabular'
use {
  'plasticboy/vim-markdown',
  config = function()
    vim.g.vim_markdown_folding_disabled = 1
    vim.g.vim_markdown_conceal = 0
    vim.g.vim_markdown_conceal_code_blocks = 0
  end,
}
