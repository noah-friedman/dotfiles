vim.api.nvim_create_augroup("ConfigureLsp", {})

---@param lsp string
---@param pattern? string | string[]
---@param config? table
---@param pre? fun(args: table)
---@param post? fun(args: table)
---@param capabilities? false Disables configuration of default and `nvim-cmp` provided capabilities
---@param formatter? false Disables configuration of auto-format on save
---@param filetypes? false Disables derivation of filetypes from `pattern`
return function(lsp, pattern, config, pre, post, capabilities, formatter, filetypes)
  ---@param args? table
  local callback = function(args)
    -- Run any pre-setup functions
    if pre then
      pre(args or {})
    end

    config = config or {}

    -- Add capabilities to the config without overriding any existing config (unless explicitly disabled)
    if capabilities ~= false then
      config.capabilities = require "cmp_nvim_lsp".default_capabilities(config.capabilities or {})
    end

    -- Set up auto-format on save (unless explicitly disabled)
    if formatter ~= false then
      local on_attach = require "lsp-format".on_attach

      if not config.on_attach then
        config.on_attach = on_attach
      else
        local save = config.on_attach
        config.on_attach = function(...)
          save(...)
          on_attach(...)
        end
      end
    end

    -- Derive filetypes from the pattern (unless explicitly disabled)
    if filetypes ~= false then
      config.filetypes = config.filetypes or {}
      for _, p in ipairs(vim.tbl_flatten { pattern }) do
        table.insert(config.filetypes, (vim.filetype.match { filename = p }))
      end
    end

    -- Set up the LSP server
    require "lspconfig"[lsp].setup(config or {})

    -- Run any post-setup functions
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
