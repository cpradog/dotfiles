local lsp = require('util.lsp')

lsp.lspconfig_setup(
  function(lspconfig)
    lspconfig.hls.setup({ on_attach = require('util.lsp').on_attach })
  end
)
