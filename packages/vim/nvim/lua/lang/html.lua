local use = require('packer').use

use 'othree/html5.vim'

use {
  'alvan/vim-closetag',
  config = function()
    vim.g.closetag_filenames = '*.xml,*.html'
    vim.g.closetag_xhtml_filenames = '*.xml,*.html'
  end,
}

require('util.lsp').lspconfig_setup(
  function(lspconfig)
    lspconfig.html.setup(
      { on_attach = require('util.lsp').on_attach, settings = { html = {} } }
    )
  end
)
