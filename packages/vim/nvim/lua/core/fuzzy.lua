local use = require('packer').use

use {
  'junegunn/fzf.vim',
  requires = { 'junegunn/fzf' },
  config = function()
    vim.g.fzf_layout = { window = { width = 1, height = 1 } }

    -- replace ag command
    vim.cmd(
      [[ command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0) ]]
    )

    -- vim integration
    vim.api.nvim_set_keymap(
      'n', '<C-p>f', ':<C-u>Files<CR>', { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p><C-f>', ':<C-u>History<CR>', { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p>b', ':<C-u>Buffers<CR>', { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p>g', ':<C-u>Ag<CR>', { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p>c', ':<C-u>Commands<CR>', { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p><C-c>', ':<C-u>History:<CR>', { noremap = true, silent = true }
    )

    -- git integration
    vim.api.nvim_set_keymap(
      'n', '<C-g>c', ':<C-u>Commits<CR>', { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-g><C-c>', ':<C-u>BCommits<CR>', { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-g>f', ':<C-u>GFiles?<CR>', { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-g><C-f>', ':<C-u>GFiles<CR>', { noremap = true, silent = true }
    )
  end,
}

use {
  'nvim-telescope/telescope.nvim',
  disable = true,
  requires = {
    { 'kyazdani42/nvim-web-devicons' },
    { 'nvim-lua/popup.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
  },
  config = function()
    require('telescope').setup(
      {
        defaults = {
          vimgrep_arguments = {
            'ag',
            '--vimgrep',
            '--nocolor',
            '--filename',
            '--numbers',
            '--column',
            '--smart-case',
          },
        },
      }
    )

    require('telescope').load_extension('fzy_native')

    -- vim integration
    vim.api.nvim_set_keymap(
      'n', '<C-p>f', '<cmd>Telescope find_files<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p><C-f>', '<cmd>Telescope oldfiles<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p>b', '<cmd>Telescope buffers<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p>g', '<cmd>Telescope live_grep<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p>c', '<cmd>Telescope commands<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p><C-c>', '<cmd>Telescope command_history<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p>t', '<cmd>Telescope tags<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p>l', '<cmd>Telescope loclist<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p>q', '<cmd>Telescope quickfix<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-p><F1>', '<cmd>Telescope man_pages<CR>',
      { noremap = true, silent = true }
    )

    -- git integration
    vim.api.nvim_set_keymap(
      'n', '<C-g>c', '<cmd>Telescope git_commits<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-g>f', '<cmd>Telescope git_files<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-g>b', '<cmd>Telescope git_branches<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-g>g', '<cmd>Telescope git_status<CR>',
      { noremap = true, silent = true }
    )
  end,
}
