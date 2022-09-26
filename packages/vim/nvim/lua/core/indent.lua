local option = vim.o
local use = require('packer').use

-- enable markers
option.list = true
option.listchars = 'tab:▸\\ ,trail:·,nbsp:.,extends:#'

-- enable auto indenting when typing
option.autoindent = true
option.smartindent = true

-- use spaces for indentation
option.expandtab = true

-- join spaces after punctuation
option.joinspaces = false

-- use tab stop for indent size
option.shiftwidth = 0

-- disable soft tab stops
option.softtabstop = 0

-- tab size
option.tabstop = 2

use {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('indent_blankline').setup(
      {
        char = '▎',
        char_highlight_list = {
          'IndentBlanklineIndent1',
          'IndentBlanklineIndent2',
          'IndentBlanklineIndent3',
          'IndentBlanklineIndent4',
          'IndentBlanklineIndent5',
          'IndentBlanklineIndent6',
        },
        use_treesitter = true,
        show_current_context = false,
        show_trailing_blankline_indent = false,
        buftype_exclude = { 'terminal', 'help' },
        filetype_exclude = { 'packer', 'man' },
      }
    )
  end,
}
