local use = require('packer').use

use {
  'pearofducks/ansible-vim',
  config = function()
    vim.g.ansible_unindent_after_newline = 1
    vim.g.ansible_attribute_highlight = 'ob'
    vim.g.ansible_name_highlight = 'd'
    vim.g.ansible_extra_keywords_highlight = 1
    vim.g.ansible_normal_keywords_highlight = 'Constant'
    vim.g.ansible_with_keywords_highlight = 'Constant'
  end,
}
