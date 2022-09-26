local Set = {}

function Set:new()
  local __values = {}
  local instance = {}
  instance.insert = function(value)
    __values[value] = true
  end

  instance.insert_values = function(values)
    if type(values) == 'table' then
      for _, v in pairs(values) do
        instance.insert(v)
      end
    end
  end

  instance.insert_keys = function(table)
    if type(table) == 'table' then
      for k in pairs(table) do
        instance.insert(k)
      end
    end
  end

  instance.asList = function()
    local list = {}
    for k in pairs(__values) do
      list[#list + 1] = k
    end
    return list
  end

  return instance
end

return Set
