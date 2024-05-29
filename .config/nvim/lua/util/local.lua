local M = {}

---@type table<string, any>
local cache = {}

---@param get string
---@param autoPrefix? false
---@return any
function M.require(get, autoPrefix)
  if autoPrefix ~= false then
    get = "local." .. get
  end

  if cache[get] == nil then
    local ok, value = pcall(require, get)
    cache[get] = ok and value or false
  end

  return cache[get] or nil
end

return M
