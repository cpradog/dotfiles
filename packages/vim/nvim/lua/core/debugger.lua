local use = require('packer').use

use {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require('dap')
    local debugger = require('util.debugger')
    debugger.dap_loaded = true

    vim.api.nvim_set_keymap(
      'n', '<F19>', '<Cmd>:lua require("dap").toggle_breakpoint()<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<F8>', '<Cmd>:lua require("dap").step_over()<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<F7>', '<Cmd>:lua require("dap").step_into()<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<F20>', '<Cmd>:lua require("dap").step_out()<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<F6>', '<Cmd>:lua require("dap").repl.open()<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<F5>', '<Cmd>:lua require("dap").continue()<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n', '<F17>', '<Cmd>:lua require("dap").run_last()<CR>',
      { noremap = true, silent = true }
    )

    vim.fn.sign_define(
      'DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' }
    )
    vim.fn.sign_define(
      'DapBreakpointRejected',
      { text = '🟫', texthl = '', linehl = '', numhl = '' }
    )
    vim.fn.sign_define(
      'DapStopped', { text = '🟢', texthl = '', linehl = '', numhl = '' }
    )

    for k, v in pairs(debugger.configurations) do
      dap.configurations[k] = v
    end

    for k, v in pairs(debugger.adapters) do
      dap.adapters[k] = v
    end
  end,
}

use {
  'rcarriga/nvim-dap-ui',
  requires = { 'mfussenegger/nvim-dap' },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    dapui.setup(
      {
        icons = { expanded = '▾', collapsed = '▸' },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
        },
        sidebar = {
          -- You can change the order of elements in the sidebar
          elements = {
            -- Provide as ID strings or tables with "id" and "size" keys
            {
              id = 'scopes',
              size = 0.25, -- Can be float or integer > 1
            },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 00.25 },
          },
          size = 40,
          position = 'left', -- Can be "left", "right", "top", "bottom"
        },
        tray = {
          elements = { 'repl' },
          size = 10,
          position = 'bottom', -- Can be "left", "right", "top", "bottom"
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil, -- Floats will be treated as percentage of your screen.
          mappings = { close = { 'q', '<Esc>' } },
        },
        windows = { indent = 1 },
      }
    )

    vim.api.nvim_set_keymap(
      'v', '<C-d>e', '<Cmd>lua require("dapui").eval()<CR>',
      { noremap = true, silent = true }
    )
  end,
}

use {
  'theHamsta/nvim-dap-virtual-text',
  requires = { 'mfussenegger/nvim-dap' },
  config = function()
    require('nvim-dap-virtual-text')
    vim.g.dap_virtual_text = true
  end,
}
