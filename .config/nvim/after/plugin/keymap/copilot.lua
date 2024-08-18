for _, config in ipairs {
  {
    lhs = "s",
    rhs = "<Cmd>Copilot panel<CR>",
  },
  {
    lhs = "c",
    rhs = "<Cmd>CopilotChat<CR>",
  },
  {
    lhs = "p",
    rhs = function()
      local t = require "CopilotChat.actions".prompt_actions() or { actions = {} }
      t.prompt = "Copilot Chat"
      t.actions["Explain diagnostic"] = {
        prompt = 'Please explain the following diagnostic issue in file: "',
        selection = require "CopilotChat.select".diagnostics,
      }
      t.actions["Fix diagnostic"] = t.actions["FixDiagnostic"]
      t.actions["FixDiagnostic"] = nil
      t.actions["Commit staged"] = t.actions["CommitStaged"]
      t.actions["CommitStaged"] = nil
      require "CopilotChat.integrations.telescope".pick(t)
    end,
  },
} do
  vim.keymap.set({ "n", "i", "v" }, "<A-c>" .. config.lhs, config.rhs)
end
