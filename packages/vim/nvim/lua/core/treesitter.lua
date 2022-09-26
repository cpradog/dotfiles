local use = require('packer').use

use { 'tpope/vim-surround', requires = 'tpope/vim-repeat' }

use 'wellle/targets.vim'

use {
  'chaoren/vim-wordmotion',
  config = function()
    vim.g.wordmotion_spaces = '_-.'
    vim.g.wordmotion_mappings = vim.api.nvim_eval(
                                  '{ \'w\' : \'w\', \'b\' : \'b\', \'e\' : \'e\', \'ge\' : \'ge\',' ..
                                    '\'aw\' : \'aw\', \'iw\' : \'iw\', \'<C-R><C-W>\' : \'<C-R><C-w>\' }'
                                )

    vim.api.nvim_set_keymap('n', 'dw', 'de', {})
    vim.api.nvim_set_keymap('n', 'cw', 'ce', {})
  end,
}

use {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    require'nvim-treesitter.configs'.setup(
      {
        ensure_installed = 'maintained',
        highlight = {
          enable = true,
          -- disable = { "typescript", "javascript" },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        indent = { enable = true },
      }
    )
  end,
}

use {
  'p00f/nvim-ts-rainbow',
  after = 'nvim-treesitter',
  config = function()
    require('nvim-treesitter.configs').setup(
      {
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = 1000,
          colors = {
            '#CC99C9',
            '#9EC1CF',
            '#9EE09E',
            '#FDFD97',
            '#FEB144',
            '#FF6663',
            '#FFFFFF',
          },
          termcolors = {
            'Red',
            'Green',
            'Yellow',
            'Blue',
            'Magenta',
            'Cyan',
            'White',
          },
        },
      }
    )
  end,
}

use {
  'JoosepAlviste/nvim-ts-context-commentstring',
  after = 'nvim-treesitter',
  requires = 'tpope/vim-commentary',
  config = function()
    require('nvim-treesitter.configs').setup(
      { context_commentstring = { enable = true } }
    )
  end,
}

use {
  'romgrk/nvim-treesitter-context',
  after = 'nvim-treesitter',
  config = function()
    require('treesitter-context').setup({ enable = true, throttle = true })
  end,
}

use {
  'RRethy/nvim-treesitter-textsubjects',
  after = 'nvim-treesitter',
  config = function()
    require'nvim-treesitter.configs'.setup {
      textsubjects = {
        enable = true,
        keymaps = {
          ['.'] = 'textsubjects-smart',
          [';'] = 'textsubjects-container-outer',
        },
      },
    }
  end,
}

use {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup()
  end,
}

