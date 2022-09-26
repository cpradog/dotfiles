local use = require('packer').use

use {
  'lewis6991/spellsitter.nvim',
  disable = true,
  config = function()
    vim.opt.spell = false
    vim.opt.spelllang = 'es,en'
    vim.opt.spellfile = vim.fn.stdpath('config') .. '/spell/es.utf-8.add'
    require('spellsitter').setup(
      {
        hl = 'SpellBad',
        captures = {
          -- 'attribute',
          'comment',
          -- 'constant',
          -- 'function',
          -- 'property',
          -- 'string',
          -- 'tag',
          -- 'type',
          -- 'variable',
        },
      }
    )
  end,
}
