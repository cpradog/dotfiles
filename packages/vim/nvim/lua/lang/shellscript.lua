local lsp = require('util.lsp')
local diagnostics = require('util.diagnostics')

lsp.lspconfig_setup(
  function(lspconfig)
    lspconfig.bashls.setup({ on_attach = require('util.lsp').on_attach })
  end
)

diagnostics.add_linter(
  'shellcheck', {
    command = 'shellcheck',
    rootPatterns = {},
    isStdout = true,
    isStderr = false,
    debounce = 100,
    args = { '--format', 'json', '-', '-x' },
    sourceName = 'shellcheck',
    parseJson = {
      line = 'line',
      column = 'column',
      endLine = 'endLine',
      endColumn = 'endColumn',
      message = '${message} [${code}]',
      security = 'level',
    },
    securities = {
      error = 'error',
      warning = 'warning',
      info = 'info',
      style = 'hint',
    },
  }
)

diagnostics.add_formatter(
  'shfmt', {
    command = 'shfmt',
    args = { '-s', '-i', '2', '-bn', '-ci', '-sr', '-filename', '%filename' },
    rootPatterns = {},
    isStdout = true,
    isStderr = false,
    doesWriteToFile = false,
    requiredFiles = {},
    ignoreExitCode = false,
  }
)

diagnostics.assign_formatter('shfmt', { 'sh' })
diagnostics.assign_linter('shellcheck', { 'sh' })
