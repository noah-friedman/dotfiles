for _, config in ipairs {
  {
    lhs = "s",
    rhs = "<Cmd>Copilot panel<CR>",
  },
  {
    lhs = "h",
    rhs = function()
      require "CopilotChat.integrations.telescope".pick(require "CopilotChat.actions".help_actions())
    end,
  },
  {
    lhs = "p",
    rhs = function()
      require "CopilotChat.integrations.telescope".pick(require "CopilotChat.actions".prompt_actions())
    end,
  },
} do
  vim.keymap.set({ "n", "i", "v" }, "<A-c>" .. config.lhs, config.rhs)
end
