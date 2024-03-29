local use = require('packer').use

use {
  'akinsho/nvim-toggleterm.lua',
  config = function()
    require('toggleterm').setup(
      {
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = '2',
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = 'horizontal',
        close_on_exit = true,
        shell = vim.o.shell,
      }
    )

    function _G.set_terminal_keymaps()
      local opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
      vim.api.nvim_buf_set_keymap(
        0, 't', '<F9>', [[<Cmd>execute v:count . "ToggleTerm"<CR>]], opts
      )
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    vim.api.nvim_set_keymap(
      '', '<F9>', [[<Cmd>execute v:count . "ToggleTerm"<CR>]],
      { noremap = true, silent = true }
    )
  end,
}
