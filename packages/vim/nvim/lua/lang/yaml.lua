local lsp = require('util.lsp')

lsp.lspconfig_setup(
  function(lspconfig)
    lspconfig.yamlls.setup(
      {
        on_attach = require('util.lsp').on_attach,
        settings = {
          yaml = {
            format = {
              enable = true,
              singleQuote = false,
              proseWrap = false,
              printWidth = 120,
            },
            validate = true,
            hover = true,
            completion = true,
            schemaStore = { enable = true, url = '' },
          },
          ['[yaml]'] = { editor = { tabSize = 2, formatOnType = true } },
        },
      }
    )
  end
)
