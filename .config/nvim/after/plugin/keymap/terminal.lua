vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set("t", "<S-Esc>", function()
                 vim.fn.chansend(vim.b.terminal_job_id, vim.api.nvim_replace_termcodes("<Esc>", true, false, true))
               end, { noremap = true })

-- Fix some terminal keymaps
for key, modifiers in pairs {
  Space = {},
  BS = { { "C", "S" }, { "C", "A" }, { "C", "S", "A" } },
  Left = {},
  Right = {},
  Up = {},
  Down = {},
} do
  Maps = {}
  ---@type (string | string[])[]
  for _, mod in ipairs { "S", "A", { "S", "A" } } do
    table.insert(modifiers, mod)
  end
  table.insert(Maps, modifiers)
  for _, mod in ipairs(modifiers) do
    local lhs = "<"
    for _, m in ipairs(type(mod) == "table" and mod or { mod --[[ @as string ]] }) do
      lhs = lhs .. m .. "-"
    end
    lhs = lhs .. key .. ">"

    vim.keymap.set("t", lhs, "<" .. key .. ">", { noremap = true })
    table.insert(Maps, lhs)
  end
end
