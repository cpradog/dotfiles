local Set = require('util.set')
local M = {}

M._setup = { filetypes = {}, linters = {}, formatFiletypes = {},
             formatters = {} }

M._root_patterns = Set:new()

M.add_formatter = function(name, config)
  M._setup.formatters[name] = config

  if config.rootPatterns then
    for _, v in ipairs(config.rootPatterns) do
      M._root_patterns.insert(v)
    end
  end
end

M.add_linter = function(name, config)
  M._setup.linters[name] = config

  if config.rootPatterns then
    for _, v in ipairs(config.rootPatterns) do
      M._root_patterns.insert(v)
    end
  end
end

M.assign_formatter = function(name, filetypes)
  if not type(filetypes) == 'table' then
    filetypes = { filetypes }
  end

  for _, v in ipairs(filetypes) do
    M._setup.formatFiletypes[v] = name
  end
end

M.assign_linter = function(name, filetypes)
  if not type(filetypes) == 'table' then
    filetypes = { filetypes }
  end

  for _, v in ipairs(filetypes) do
    M._setup.filetypes[v] = name
  end
end

M.init = function()
  require('util.lsp').lspconfig_setup(
    function(lspconfig)
      local filetypes = require('util.set'):new()
      filetypes.insert_keys(M._setup.filetypes)
      filetypes.insert_keys(M._setup.formatFiletypes)

      lspconfig.diagnosticls.setup(
        {
          on_attach = require('util.lsp').on_attach,
          filetypes = filetypes.asList(),
          format = true,
          init_options = M._setup,
          root_dir = function(fname)
            local util = require('lspconfig.util')
            return util.root_pattern(M._root_patterns.asList())(fname) or
                     util.path.dirname(fname)
          end,
        }
      )
    end
  )
end

return M
