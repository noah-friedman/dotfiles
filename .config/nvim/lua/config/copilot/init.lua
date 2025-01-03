local M = {}

function M.setup()
  require "copilot".setup {
    filetypes = {
      yaml = true,
      markdown = true,
    },
    panel = {
      keymap = {
        jump_next = "<S-Down>",
        jump_prev = "<S-Up>",
        accept = "<S-Enter>",
        refresh = "<S-BS>",
      }
    },
    suggestion = {
      auto_trigger = false,
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

-- Add keymaps for the copilot panel
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot://*",
  ---@param args
  callback = function(args)
    for _, key in ipairs { "q", "<C-c>" } do
      vim.keymap.set("n", key, "<Cmd>q<CR>", { buffer = args.buf })
    end
  end
})

return M
