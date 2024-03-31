vim.keymap.set("i", "<S-BS>", function()
    local copilot = require"copilot.suggestion"

    if copilot.is_visible() then
        copilot.dismiss()
    else
        return "<S-BS>"
    end
end, { expr = true })

vim.g.coq_settings = vim.tbl_deep_extend("keep", vim.g.coq_settings or {}, {
    keymap = {
        jump_to_mark = "<M-m>",
    }
})
