local M = {}

function M.setup()
  require "copilot".setup {
    suggestion = {
      auto_trigger = true,
      hide_during_completion = false,
      -- See `config.cmp` for overriden keymap
      -- These are only here to show the keymap when `cmp` isn't loaded
      keymap = {
        next = "<S-Down>",
        prev = "<S-Up>",
        accept = "<S-Enter>",
        dismiss = "<S-BS>",
      },
    },
  }
end

-- Configure highlight groups
vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#969696", italic = true })

return M
