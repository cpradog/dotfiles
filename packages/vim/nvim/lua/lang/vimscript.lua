local use = require('packer').use

use {
  'Shougo/neco-vim',
  after = 'nvim-lspconfig',
  config = function()
    require('lspconfig').vimls.setup(
      { on_attach = require('util.lsp').on_attach }
    )
  end,
}
