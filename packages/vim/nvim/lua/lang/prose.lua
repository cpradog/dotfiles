local use = require('packer').use
local diagnostics = require('util.diagnostics')

use { 'panozzaj/vim-autocorrect' }
use { 'dbmrq/vim-ditto' }
use { 'dhruvasagar/vim-table-mode' }

function ProseMode()
  vim.cmd([[ call AutoCorrect() ]])
  vim.cmd([[ DittoOn ]])
  vim.wo.wrap = true
  vim.bo.textwidth = 80

  -- go to next overused word
  vim.api.nvim_set_keymap(
    'n', ']d', '<Plug>DittoNext', { noremap = false, silent = true }
  )

  -- go to previous overused word
  vim.api.nvim_set_keymap(
    'n', '[d', '<Plug>DittoPrev', { noremap = false, silent = true }
  )

  -- ignore current word
  vim.api.nvim_set_keymap(
    'n', '+d', '<Plug>DittoGood', { noremap = false, silent = true }
  )

  -- stop ignoring current word
  vim.api.nvim_set_keymap(
    'n', '-d', '<Plug>DittoBad', { noremap = false, silent = true }
  )

  -- show next match
  vim.api.nvim_set_keymap(
    'n', '<C-d>j', '<Plug>DittoMore', { noremap = false, silent = true }
  )

  -- show previous match
  vim.api.nvim_set_keymap(
    'n', '<C-d>k', '<Plug>DittoLess', { noremap = false, silent = true }
  )
end

vim.cmd([[ autocmd FileType text,asciidoc4,markdown,tex lua ProseMode() ]])

diagnostics.add_linter(
  'languagetool', {
    sourceName = 'languagetool',
    command = 'languagetool',
    debounce = 200,
    args = { '-' },
    offsetLine = 0,
    offsetColumn = 0,
    formatLines = 2,
    formatPattern = {
      [[^\d+?\.\)\s+Line\s+(\d+),\s+column\s+(\d+),\s+([^\n]+)\nMessage:\s+(.*)(\r|\n)*$]],
      { line = 1, column = 2, message = { '[languagetool] ', 4, 3 } },
    },
  }
)
diagnostics.assign_linter('languagetool', { 'markdown', 'asciidoc4' })
