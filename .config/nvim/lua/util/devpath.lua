local M = {}

---@return { path: string, patterns: string[] } | false
function M.get()
  return require "util.local".require "devpath"
end

---@param input string
---@return boolean
function M.match(input)
  local got = M.get()
  return got and got.path:match(input) or false
end

return M
