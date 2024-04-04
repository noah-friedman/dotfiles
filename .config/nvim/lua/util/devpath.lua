local M = {}

local cached = nil

---@return { path: string, patterns: string[] } | false
function M.get()
  if cached ~= nil then
    return cached
  end

  local success, result = pcall(require "devpath")
  cached = success and result or false
  return cached
end

---@param input string
---@return boolean
function M.match(input)
  local got = M.get()

  return got and got.path:match(input) or false
end

return M
