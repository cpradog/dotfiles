local helpers = require('util.helpers')
local M = {}

M._on_attach_functions = {}

M.add_on_attach = function(on_attach)
  table.insert(M._on_attach_functions, on_attach)
end

M.on_attach = function(client, bufnr)
  for _, fn in ipairs(M._on_attach_functions) do
    helpers.silent_call(fn, client, bufnr)
  end
end

M._lspconfig_config = {}
M.lspconfig_setup = function(callback)
  local ready, lspconfig = pcall(require, 'lspconfig')
  if not ready then
    table.insert(M._lspconfig_config, callback)
  else
    callback(lspconfig)
  end
end

require('packer').use {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')
    for _, fn in ipairs(require('util.lsp')._lspconfig_config) do
      helpers.silent_call(fn, lspconfig)
    end
  end,
}

return M
