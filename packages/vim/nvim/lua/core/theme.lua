local option = vim.o
local use = require('packer').use

-- change terminal title
option.title = true

-- use 24-bit color palette
option.termguicolors = true

-- use dark theme
option.background = 'dark'

use {
  'projekt0n/github-nvim-theme',
  config = function()
    require('github-theme').setup(
      {
        theme_style = 'dimmed',
        comment_style = 'italic',
        keyword_style = 'NONE',
        hide_end_of_buffer = true,
        hide_inactive_statusline = true,
        dark_sidebar = true,
        dark_float = true,
        sidebars = {
          'NvimTree',
          'qf',
          'vista_kind',
          'toggleterm',
          'terminal',
          'packer',
          'fzf',
        },
      }
    )

    vim.cmd [[ highlight IndentBlanklineIndent1 guifg=#931f29 guibg=NONE gui=NONE blend=nocombine ]]
    vim.cmd [[ highlight IndentBlanklineIndent2 guifg=#a67721 guibg=NONE gui=NONE blend=nocombine ]]
    vim.cmd [[ highlight IndentBlanklineIndent3 guifg=#4c7133 guibg=NONE gui=NONE blend=nocombine ]]
    vim.cmd [[ highlight IndentBlanklineIndent4 guifg=#22575e guibg=NONE gui=NONE blend=nocombine ]]
    vim.cmd [[ highlight IndentBlanklineIndent5 guifg=#1163a7 guibg=NONE gui=NONE blend=nocombine ]]
    vim.cmd [[ highlight IndentBlanklineIndent6 guifg=#7d2697 guibg=NONE gui=NONE blend=nocombine ]]
    vim.cmd [[ highlight PmenuSel cterm=bold guifg=#373e47 guibg=#6cb6ff ]]
    vim.cmd [[ highlight NormalFloat guibg=Black blend=100 ]]
    vim.cmd [[ highlight Comment ctermfg=14 gui=italic guifg=#8ddb8c ]]
    vim.cmd [[ highlight GitSignsCurrentLineBlame ctermfg=14 gui=italic guifg=#768390 ]]
    vim.cmd [[ highlight BufferLineFill guibg=#000000 ]]
    vim.cmd [[ highlight BufferLineTab guibg=#000000 guifg=#768390 ]]
    vim.cmd [[ highlight BufferLineTabSelected guibg=#191d22 guifg=#6cb6ff ]]
  end,
}
