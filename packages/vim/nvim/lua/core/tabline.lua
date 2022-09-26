local option = vim.o
local use = require('packer').use

-- always show tabline
option.showtabline = 2

-- max number of tabs to show
option.tabpagemax = 15

use {
  'akinsho/nvim-bufferline.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('bufferline').setup(
      {
        options = {
          separator_style = 'slant',
          always_show_bufferline = true,
          show_close_icon = false,
          close_command = 'BufDel! %d',
          right_mouse_command = 'BufDel! %d',
          left_mouse_command = 'buffer %d',
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(count, level, diag, context)
            local s = ' '
            for e, n in pairs(diag) do
              local sym = e == 'error' and ' ' or
                            (e == 'warning' and ' ' or '')
              s = s .. n .. sym
            end
            return s
          end,
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              highlight = 'Directory',
            },
            {
              filetype = 'Mundo',
              text = 'Undo tree',
              highlight = 'PanelHeading',
              padding = 1,
            },
          },
        },
        highlights = {
          fill = { guibg = '#000000' },
          tab = { guifg = '#768390', guibg = '#000000' },
          tab_selected = { guifg = '#6cb6ff', guibg = '#191d22' },
        },
      }
    )
  end,
}

