local M = {}

function M.setup()
    require"copilot".setup {
        suggestion = {
            auto_trigger = true,
            hide_during_completion = false,
            -- See `config.cmp` for keymap
        },
    }
end

-- Configure highlight groups
vim.cmd.highlight [[ CopilotSuggestion cterm=italic gui=italic guifg=#969696 ]]

return M
