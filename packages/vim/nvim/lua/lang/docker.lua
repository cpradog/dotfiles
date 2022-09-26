local lsp = require('util.lsp')

lsp.lspconfig_setup(
  function(lspconfig)
    lspconfig.dockerls.setup({ on_attach = require('util.lsp').on_attach })
  end
)
