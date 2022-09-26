local use = require('packer').use
local diagnostics = require('util.diagnostics')

function NLua_install_sumneko()
  print('installing sumneko lua language server...')
  local GITHUB_URL = 'https://github.com/sumneko/lua-language-server/'
  local directory = require('nlua.lsp.nvim').base_directory
  local cwd = vim.fn.getcwd()

  if vim.fn.isdirectory(directory) == 0 then
    vim.fn.system({ 'git', 'clone', GITHUB_URL, directory })
  else
    vim.fn.system({ 'git', 'pull' })
  end

  vim.cmd('cd ' .. directory)
  vim.fn.system({ 'git', 'submodule', 'update', '--init', '--recursive' })

  vim.cmd('cd ' .. directory .. '/3rd/luamake')
  local uname = string.lower(jit.os)
  if uname == 'osx' then
    uname = 'macos'
  end

  vim.fn.system(
    { 'ninja', '-f', string.format('compile/ninja/%s.ninja', uname) }
  )

  vim.cmd('cd ' .. directory)
  vim.fn.system({ './3rd/luamake/luamake', 'rebuild' })

  if uname == 'macos' then
    vim.fn.system({ 'mv', 'bin/macOS', 'bin/OSX' })
  end

  vim.cmd('cd ' .. cwd)
  print('sumneko lua language server installed')
end

use { 'nvim-lua/plenary.nvim' }
use { 'euclidianAce/BetterLua.vim' }

use {
  'tjdevries/nlua.nvim',
  after = { 'plenary.nvim', 'nvim-lspconfig' },
  run = { NLua_install_sumneko },
  config = function()
    if vim.fn.isdirectory(require('nlua.lsp.nvim').base_directory) == 0 then
      NLua_install_sumneko()
    end

    require('nlua.lsp.nvim').setup(
      require('lspconfig'),
      { on_attach = require('util.lsp').on_attach, globals = {} }
    )
  end,
}

diagnostics.add_linter(
  'luacheck', {
    command = 'luacheck',
    args = { '--codes', '--no-color', '--quiet', '%filepath' },
    rootPatterns = { '.luacheckrc' },
    offsetLine = 0,
    offsetColumn = 0,
    formatLines = 1,
    formatPattern = {
      [[^.*:(\d+):(\d+):\s\(([W|E])\d+\)\s(.*)(\r|\n)*$]],
      { line = 1, column = 2, security = 3, message = { '[luacheck] ', 4 } },
    },
    securities = { E = 'error', W = 'warning' },
  }
)
diagnostics.add_formatter(
  'lua-format', {
    command = 'lua-format',
    args = {},
    rootPatterns = { '.lua-format' },
    isStdout = true,
    isStderr = false,
    doesWriteToFile = false,
    requiredFiles = { '.lua-format' },
    ignoreExitCode = false,
  }
)
diagnostics.assign_linter('luacheck', { 'lua' })
diagnostics.assign_formatter('lua-format', { 'lua' })

vim.cmd(
  [[
    augroup luacheck
      autocmd!
      autocmd BufNewFile,BufReadPost,FileReadPost .luacheckrc set filetype=lua
    augroup END
  ]]
)
