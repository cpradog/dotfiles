local use = require('packer').use
local lsp = require('util.lsp')
local diagnostics = require('util.diagnostics')
local debugger = require('util.debugger')

use {
  'meain/vim-package-info',
  run = 'npm install',
  config = function()
    vim.g.vim_package_info_virutaltext_prefix = '  ﮮ '
    vim.g.vim_package_info_virutaltext_highlight = 'VimPackageInfoText'

    vim.cmd(
      [[
        hi VimPackageInfoText  guifg=#eeeeb3
        hi VimPackageInfoPatch guifg=#8BC34A
        hi VimPackageInfoMinor guifg=#00BCD4
        hi VimPackageInfoMajor guifg=#F44336
      ]]
    )
  end,
}

use {
  'pangloss/vim-javascript',
  config = function()
    vim.g.javascript_plugin_jsdoc = 1
    vim.g.javascript_plugin_ngdoc = 1
  end,
}

use { 'yuezk/vim-js' }

use {
  'MaxMEllon/vim-jsx-pretty',
  config = function()
    vim.g.vim_jsx_pretty_colorful_config = 1
  end,
}

use { 'HerringtonDarkholme/yats.vim' }

use {
  'Quramy/vim-js-pretty-template',
  config = function()
    vim.cmd(
      [[
        augroup js-pretty
          autocmd!
          autocmd FileType javascript hi def link jsObjectKey Label
          autocmd FileType typescript JsPreTmpl
          autocmd FileType typescript.tsx JsPreTmpl
          autocmd FileType javascript.jsx JsPreTmpl
          autocmd FileType javascriptreact JsPreTmpl
          autocmd FileType typescriptreact JsPreTmpl
        augroup END
      ]]
    )
  end,
}

use { 'othree/jsdoc-syntax.vim' }

-- use { 'eliba2/vim-node-inspect' }

lsp.lspconfig_setup(
  function(lspconfig)
    lspconfig.tsserver.setup(
      {
        on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.range_formatting = false
          require('util.lsp').on_attach(client, bufnr)
        end,
        init_options = {
          preferences = {
            quotePreference = 'single',
            includeCompletionsForModuleExports = true,
            includeCompletionsForImportStatements = true,
            includeCompletionsWithSnippetText = false,
            includeCompletionsWithInsertText = true,
            includeAutomaticOptionalChainCompletions = true,
            importModuleSpecifierPreference = 'project-relative',
            importModuleSpecifierEnding = 'minimal',
            allowTextChangesInNewFiles = true,
            lazyConfiguredProjectsFromExternalProject = true,
            providePrefixAndSuffixTextForRename = true,
            provideRefactorNotApplicableReason = true,
            allowRenameOfImportPath = true,
            includePackageJsonAutoImports = 'on',
            displayPartsForJSDoc = true,
            generateReturnInDocTemplate = true,
          },
        },
        settings = {
          tsserver = { enableJavascript = false },
          javascript = {
            validate = false,
            suggestionActions = { enabled = false },
          },
          typescript = { suggestionActions = { enabled = false } },
        },
      }
    )
  end
)

diagnostics.add_linter(
  'eslint', {
    sourceName = 'eslint',
    command = 'eslint_d',
    debounce = 100,
    args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
    parseJson = {
      errorsRoot = '[0].messages',
      line = 'line',
      column = 'column',
      endLine = 'endLine',
      endColumn = 'endColumn',
      message = '[eslint] ${message} [${ruleId}]',
      security = 'severity',
    },
    securities = { [2] = 'error', [1] = 'warning' },
    rootPatterns = {
      '.eslintrc',
      '.eslintrc.cjs',
      '.eslintrc.js',
      '.eslintrc.json',
      '.eslintrc.yaml',
      '.eslintrc.yml',
      'package.json',
    },
  }
)

diagnostics.assign_linter(
  'eslint', { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }
)

diagnostics.add_formatter(
  'prettier', {
    command = 'prettier_d_slim',
    args = { '--stdin', '--stdin-filepath', '%filepath' },
    rootPatterns = { 'package.json' },
    isStdout = true,
    isStderr = false,
    doesWriteToFile = false,
    requiredFiles = {},
    ignoreExitCode = false,
  }
)

diagnostics.add_formatter(
  'eslint', {
    command = 'eslint_d',
    args = {
      '--stdin',
      '--stdin-filename',
      '%filepath',
      '--format',
      'json',
      '--fix-to-stdout',
    },
    rootPatterns = {
      '.eslintrc',
      '.eslintrc.cjs',
      '.eslintrc.js',
      '.eslintrc.json',
      '.eslintrc.yaml',
      '.eslintrc.yml',
      'package.json',
    },
    isStdout = true,
    isStderr = false,
    doesWriteToFile = false,
    requiredFiles = {},
    ignoreExitCode = false,
  }
)

diagnostics.assign_formatter(
  { 'eslint', 'prettier' },
  { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }
)

debugger.add_adapter(
  'node-debug2', {
    name = 'node',
    type = 'executable',
    command = 'node',
    args = {
      os.getenv('HOME') .. '/projects/vscode-node-debug2/out/src/nodeDebug.js',
    },
  }
)

debugger.add_configuration(
  { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }, {
    {

      name = 'jest',
      type = 'node-debug2',
      request = 'launch',
      program = '${workspaceFolder}/node_modules/.bin/jest',
      args = { '--runInBand', '${workspaceFolder}/${file}' },
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
  }
)
