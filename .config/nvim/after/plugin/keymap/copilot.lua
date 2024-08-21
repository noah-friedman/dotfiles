for _, config in ipairs {
  {
    lhs = "s",
    rhs = "<Cmd>Copilot panel<CR>",
  },
  {
    lhs = "c",
    rhs = "<Cmd>CopilotChat<CR>",
  },
} do
  vim.keymap.set({ "n", "i", "v" }, "<A-c>" .. config.lhs, config.rhs)
end
