local M = {}

function M.setup()
    require"copilot".setup {
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
vim.cmd.highlight [[ CopilotSuggestion cterm=italic gui=italic guifg=#969696 ]]

return M
