local M = {}

---@param label string
---@param shortcut string
---@param action function
---@param config? table
---@param keyopts? table
---@return table
function M.button(label, shortcut, action, config, keyopts)
  return vim.tbl_deep_extend("force", {
                               type = "button",
                               val = label,
                               on_press = action,
                               opts = {
                                 keymap = { "n", shortcut, action, keyopts or { noremap = true } },
                                 shortcut = shortcut,
                                 align_shortcut = "right",
                                 hl_shortcut = "Keyword",
                                 position = "center",
                                 cursor = 3,
                                 width = 50,
                               },
                             }, config or {})
end

function M.get()
  return require "util.local".require "alpha"
end

return M
