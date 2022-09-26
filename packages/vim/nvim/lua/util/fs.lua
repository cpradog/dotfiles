local M = {}

M.config_file = function(relative_path)
  return vim.fn.stdpath('config') .. relative_path
end

M.glob = function(pattern)
  local files = vim.fn.split(vim.fn.glob(pattern), '\n')
  table.sort(
    files, function(a, b)
      return a:upper() < b:upper()
    end
  )
  return files
end

M.exists = function(file)
  return vim.fn.filereadable(file)
end

M.basename_without_extension = function(file)
  return vim.fn.fnamemodify(file, ':t:r')
end

M.source_all = function(package)
  local files = M.glob(
                  vim.fn.stdpath('config') .. '/lua/' .. package .. '/*.lua'
                )
  for _, file in ipairs(files) do
    file = M.basename_without_extension(file)

    if file ~= 'init' then
      require(string.gsub(package, '/', '.') .. '.' .. file)
    end

  end
end

return M

