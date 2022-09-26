local use = require('packer').use

use {
  -- official repo: 'glepnir/lspsaga.nvim',
  -- workaround last version incompatibility
  'rinx/lspsaga.nvim',
  config = function()
    require('lspsaga').init_lsp_saga(
      {
        use_saga_diagnostic_sign = true,
        error_sign = '✘',
        warn_sign = '',
        hint_sign = 'כֿ',
        infor_sign = '',
        dianostic_header_icon = '   ',
        code_action_icon = ' ',
        code_action_prompt = {
          enable = false,
          sign = true,
          sign_priority = 20,
          virtual_text = true,
        },
        finder_definition_icon = '  ',
        finder_reference_icon = '  ',
        max_preview_lines = 10,
        finder_action_keys = {
          open = 'o',
          vsplit = 's',
          split = 'i',
          quit = 'q',
          scroll_down = '<C-f>',
          scroll_up = '<C-b>',
        },
        code_action_keys = { quit = '<ESC>', exec = '<CR>' },
        rename_action_keys = { quit = '<ESC>', exec = '<CR>' },
        definition_preview_icon = '  ',
        border_style = 'single',
        rename_prompt_prefix = '➤',
      }
    )

    require('util.lsp').add_on_attach(
      function(client, bufnr)
        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', '[e', '<Cmd>Lspsaga diagnostic_jump_prev<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', ']e', '<Cmd>Lspsaga diagnostic_jump_next<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', '<C-d>', '<Cmd>Lspsaga preview_definition<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', 'gd',
          '<Cmd>lua require("util.helpers").silent_call(vim.lsp.buf.definition)<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', 'gD',
          '<Cmd>lua require("util.helpers").silent_call(vim.lsp.buf.declaration)<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', 'gt',
          '<Cmd>lua require("util.helpers").silent_call(vim.lsp.buf.type_definition)<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', 'gi',
          '<Cmd>lua require("util.helpers").silent_call(vim.lsp.buf.implementation)<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', 'gr',
          '<Cmd>lua require("util.helpers").silent_call(vim.lsp.buf.references)<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', 'K', '<Cmd>Lspsaga hover_doc<CR>',
          { noremap = true, silent = true }
        )

        -- vim.api.nvim_buf_set_keymap(
        --   bufnr, 'n', '<ALT-j>',
        --   '<Cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>',
        --   { noremap = true, silent = true }
        -- )

        -- vim.api.nvim_buf_set_keymap(
        --   bufnr, 'n', '<ALT-k>',
        --   '<Cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>',
        --   { noremap = true, silent = true }
        -- )

        -- vim.api.nvim_buf_set_keymap(
        --   bufnr, 'n', '<C-K>', '<Cmd>Lspsaga signature_help<CR>',
        --   { noremap = true, silent = true }
        -- )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', 'gh',
          '<Cmd>lua require("util.helpers").silent_call(vim.lsp.buf.incoming_calls)<CR>',
          { noremap = true, silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', 'gH',
          '<Cmd>lua require("util.helpers").silent_call(vim.lsp.buf.outgoing_calls)<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', '<F3>',
          '<Cmd>lua require("util.helpers").silent_call(vim.lsp.buf.document_symbol)<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', '<F3><F3>',
          '<Cmd>lua require("util.helpers").silent_call(vim.lsp.buf.workspace_symbol)<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', '<C-a>', '<Cmd>Lspsaga code_action<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', '<C-f>',
          '<Cmd>lua require("util.helpers").silent_call(vim.lsp.buf.formatting_sync, nil, 10000)<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'v', '<C-f>',
          '<Cmd>lua require("util.helpers").silent_call(vim.lsp.buf.range_formatting, nil, 10000)<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          bufnr, 'n', '<F2>', '<Cmd>Lspsaga rename<CR>',
          { noremap = true, silent = true }
        )

        vim.cmd(
          [[
            autocmd CursorHold,CursorHoldI <buffer> Lspsaga show_line_diagnostics
          ]]
        )

        if client.resolved_capabilities.document_formatting then
          vim.cmd(
            [[ autocmd BufWritePre <buffer> lua require("util.helpers").silent_call(vim.lsp.buf.formatting_sync, nil, 10000) ]]
          )
        end

        if client.resolved_capabilities.document_highlight then
          vim.cmd(
            [[
              autocmd CursorHold,CursorHoldI  <buffer> lua require("util.helpers").silent_call(vim.lsp.buf.document_highlight)
              autocmd CursorHold,CursorMovedI <buffer> lua require("util.helpers").silent_call(vim.lsp.buf.clear_references)
            ]]
          )
        end

        if client.resolved_capabilities.code_action then
          vim.cmd(
            [[ autocmd CursorHold,CursorHoldI <buffer> lua require("util.helpers").silent_call(require('lspsaga.codeaction').code_action_prompt) ]]
          )
        end
      end
    )

    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
                                                            vim.lsp.diagnostic
                                                              .on_publish_diagnostics,
                                                            {
        virtual_text = false,
        underline = true,
        signs = true,
      }
                                                          )
  end,
}
