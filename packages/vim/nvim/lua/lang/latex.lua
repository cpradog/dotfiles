local use = require('packer').use
local lsp = require('util.lsp')

use {
  'lervag/vimtex',
  config = function()
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_view_general_viewer = 'evince'
    vim.g.vimtex_compiler_latexmk = {
      options = {
        '-pdf',
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      },
    }

    vim.cmd(
      [[
        augroup latex
          autocmd!
          autocmd Filetype tex setl makeprg=make
          autocmd Filetype tex setl textwidth=80
        augroup END
      ]]
    )
  end,
}

lsp.lspconfig_setup(
  function(lspconfig)
    lspconfig.texlab.setup(
      {
        on_attach = require('util.lsp').on_attach,
        settings = {
          texlab = { chktex = { onOpenAndSave = true, onEdit = true } },
        },
      }
    )
  end
)

