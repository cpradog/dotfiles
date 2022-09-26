local lsp = require('util.lsp')
local diagnostics = require('util.diagnostics')

lsp.lspconfig_setup(
  function(lspconfig)
    lspconfig.pyright.setup(
      { on_attach = require('util.lsp').on_attach, settings = { pyright = {} } }
    )
  end
)

diagnostics.add_formatter(
  'autopep8', {
    command = 'autopep8',
    args = { '-' },
    rootPatterns = { 'requirements.txt' },
    isStdout = true,
    isStderr = false,
    doesWriteToFile = false,
    requiredFiles = {},
    ignoreExitCode = false,
  }
)

diagnostics.assign_formatter({ 'autopep8' }, { 'python' })
