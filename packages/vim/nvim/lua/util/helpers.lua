local M = {}

M.noop = function(...)
  return ...
end

-- convert a nested table to a flat table
M.flatten = function(t, sep, key_modifier, res)
  if type(t) ~= 'table' then
    return t
  end

  if sep == nil then
    sep = '.'
  end

  if res == nil then
    res = {}
  end

  if key_modifier == nil then
    key_modifier = M.noop
  end

  for k, v in pairs(t) do
    if type(v) == 'table' then
      local flattenedV = M.flatten(v, sep, key_modifier, {})
      for k2, v2 in pairs(flattenedV) do
        res[key_modifier(k) .. sep .. key_modifier(k2)] = v2
      end
    else
      res[key_modifier(k)] = v
    end
  end
  return res
end

M.silent_call = function(fn, arg1, ...)
  local _ = pcall(fn, arg1, ...)
end

return M
