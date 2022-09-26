local M = {}

M.dap_loaded = false
M.configurations = {}
M.adapters = {}

function M.add_configuration(filetypes, configurations)
  if not type(filetypes) == 'table' then
    filetypes = { filetypes }
  end

  for _, v in ipairs(filetypes) do
    if M.dap_loaded then
      require('dap').configurations[v] = configurations
    else
      M.configurations[v] = configurations
    end
  end
end

function M.add_adapter(name, config)
  if M.dap_loaded then
    require('dap').adapters[name] = config
  else
    M.adapters[name] = config
  end
end

return M
