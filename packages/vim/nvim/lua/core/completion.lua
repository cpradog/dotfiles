local use = require('packer').use
local option = vim.o

option.completeopt = 'menuone,noselect'

use {
  'hrsh7th/nvim-compe',
  config = function()
    require('compe').setup(
      {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'enable',
        throttle_time = 80,
        source_timeout = 200,
        resolve_timeout = 800,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = {
          border = { '', '', '', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
          winhighlight = 'NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder',
          max_width = 120,
          min_width = 60,
          max_height = math.floor(vim.o.lines * 0.3),
          min_height = 1,
        },
        source = {
          path = true,
          buffer = true,
          calc = true,
          nvim_lsp = true,
          nvim_lua = true,
          vsnip = false,
          ultisnips = true,
          luasnip = true,
        },
      }
    )

    local t = function(str)
      return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local check_back_space = function()
      local col = vim.fn.col('.') - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    -- Use (s-)tab to:
    --- move to prev/next item in completion menuone
    --- jump to prev/next snippet's placeholder
    _G.tab_complete = function()
      if vim.fn.pumvisible() == 1 then
        return t('<C-n>')
      elseif check_back_space() then
        return t('<Tab>')
      else
        return vim.fn['compe#complete']()
      end
    end
    _G.s_tab_complete = function()
      if vim.fn.pumvisible() == 1 then
        return t('<C-p>')
      else
        -- If <S-Tab> is not working in your terminal, change it to <C-h>
        return t('<S-Tab>')
      end
    end

    vim.api.nvim_set_keymap(
      'i', '<C-Space>', 'compe#complete()',
      { noremap = true, silent = true, expr = true }
    )
    vim.api.nvim_set_keymap(
      'i', '<CR>', 'compe#confirm("<CR>")',
      { noremap = true, silent = true, expr = true }
    )
    vim.api.nvim_set_keymap(
      'i', '<C-e>', 'compe#close("<C-e>")',
      { noremap = true, silent = true, expr = true }
    )
    vim.api.nvim_set_keymap(
      'i', '<C-f>', 'compe#scroll({ "delta": +4 })',
      { noremap = true, silent = true, expr = true }
    )
    vim.api.nvim_set_keymap(
      'i', '<C-d>', 'compe#scroll({ "delta": -4 })',
      { noremap = true, silent = true, expr = true }
    )
    vim.api.nvim_set_keymap(
      'i', '<Tab>', 'v:lua.tab_complete()',
      { noremap = true, silent = true, expr = true }
    )
    vim.api.nvim_set_keymap(
      's', '<Tab>', 'v:lua.tab_complete()',
      { noremap = true, silent = true, expr = true }
    )
    vim.api.nvim_set_keymap(
      'i', '<S-Tab>', 'v:lua.s_tab_complete()',
      { noremap = true, silent = true, expr = true }
    )
    vim.api.nvim_set_keymap(
      's', '<S-Tab>', 'v:lua.s_tab_complete()',
      { noremap = true, silent = true, expr = true }
    )
    vim.cmd('highlight link CompeDocumentation NormalFloat')
  end,
}

use {
  'cohama/lexima.vim',
  config = function()
    vim.g.lexima_enable_basic_rules = 1
    vim.g.lexima_enable_newline_rules = 1
    vim.g.lexima_enable_space_rules = 1
    vim.g.lexima_enable_endwise_rules = 1
    vim.g.lexima_accept_pum_with_enter = 0
  end,
}

use {
  'onsails/lspkind-nvim',
  config = function()
    require('lspkind').init(
      {
        with_text = false,
        symbol_map = {
          Text = '',
          Method = '',
          Function = '',
          Constructor = '',
          Field = 'ﰠ',
          Variable = '',
          Class = 'ﴯ',
          Interface = '',
          Module = '',
          Property = 'ﰠ',
          Unit = '塞',
          Value = '',
          Enum = '',
          Keyword = '',
          Snippet = '',
          Color = '',
          File = '',
          Reference = '',
          Folder = '',
          EnumMember = '',
          Constant = '',
          Struct = 'פּ',
          Event = '',
          Operator = '',
          TypeParameter = '',
        },
      }
    )
  end,
}
