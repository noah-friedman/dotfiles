local otter = require "otter"
local function_maps = {
  otter.ask_hover,
  otter.ask_rename,
  vim.lsp.buf.code_action,
  otter.ask_definition,
  vim.diagnostic.open_float,
  function()
    require "copilot.suggestion".toggle_auto_trigger()
  end,
  vim.cmd.noh,
  function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 })
  end
}

for index, mapping in ipairs(function_maps) do
  vim.keymap.set({ "n", "i", "v" }, "<F" .. index .. ">", (type(mapping) == "function") and mapping or mapping[1],
                 { noremap = true })
  if type(mapping) == "table" and mapping[2] then
    vim.keymap.set({ "n", "i", "v" }, "<S-F" .. index .. ">", mapping[2], { noremap = true })
  end
end
