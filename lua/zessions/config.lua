local default_config = {
  cwd = vim.fn.stdpath("data").."/sessions",
  force_overwrite = false,
  force_delete = false,
  bdelete = false,
  verbose = true,
}

local config = vim.deepcopy(default_config)

local mt = {}

mt.__index = mt

mt.__newindex = function(self, k, v)
  error("Assigning new values is not allowed !")
end

mt.update = function(self, new_config)
  local new_config = new_config or {}
  for k, v in pairs(self) do
    if new_config[k] ~= nil then self[k] = new_config[k] end
  end
  return self
end

mt.reset = function(self)
  for k, v in pairs(default_config) do self[k] = v end
  return self
end

return setmetatable(config, mt)
