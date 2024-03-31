-- Autocommand that emits on first LspAttach that is not from Copilot
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        if vim.lsp.get_client_by_id(args.data.client_id).name ~= "copilot" then
            vim.api.nvim_exec_autocmds("User", {
                pattern = "NotCopilot",
            })
            return true
        end
    end
})
