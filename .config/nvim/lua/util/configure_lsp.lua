vim.api.nvim_create_augroup("ConfigureLsp", {})

---@param lsp string
---@param pattern? string | string[]
---@param config? table
---@param pre? fun(args: table)
---@param post? fun(args: table)
---@param capabilities? false
return function(lsp, pattern, config, pre, post, capabilities)
    ---@param args? table
    local callback = function(args)
        if pre then
            pre(args or {})
        end

        if capabilities ~= false then
            config = config or {}
            config.capabilities = require"cmp_nvim_lsp".default_capabilities(config.capabilities or {})
        end

        require("lspconfig")[lsp].setup(config or {})

        if post then
            post(args or {})
        end
    end

    if pattern then
        vim.api.nvim_create_autocmd({ "BufNew", "BufNewFile", "BufReadPre" }, {
            group = "ConfigureLsp",
            once = true,
            pattern = pattern,
            callback = function(args)
                callback(args)
                vim.schedule(vim.cmd.LspStart)
            end,
        })
    else
        callback()
    end
end
