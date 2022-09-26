local use = require('packer').use

use {
  'ronakg/quickr-preview.vim',
  config = function()
    vim.g.quickr_preview_position = 'right'
    vim.g.quickr_preview_options = 'number norelativenumber nofoldenable'
    vim.g.quickr_preview_exit_on_enter = 0
    vim.g.quickr_preview_on_cursor = 1
    vim.g.quickr_preview_modifiable = 0

    vim.cmd [[
      augroup quickr-preview
      autocmd!
      autocmd BufEnter quickfix setlocal nobuflisted
      autocmd FileType qf nnoremap q <Cmd>close<CR>
      augroup END
    ]]
  end,
}

use {
  'drmingdrmer/vim-toggle-quickfix',
  config = function()
    vim.api.nvim_set_keymap(
      'n', '<F11>', '<Plug>window:quickfix:loop', { silent = true }
    )
  end,
}

