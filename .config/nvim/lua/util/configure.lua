local M = {}

---@param plugin string
---@return fun(): nil
local function configure(plugin)
  return function()
    require("config." .. plugin).setup()
  end
end
local mt = {
  __call = function(_, plugin)
    return configure(plugin)
  end,
}

vim.api.nvim_create_augroup("ConfigureLsp", {})

---@class ConfigureLspOptions
---@field lsp string
---@field pattern? string | string[]
---@field config? table
---@field pre? fun(args: table)
---@field post? fun(args: table)
---@field capabilities? false Disables configuration of default and `nvim-cmp` provided capabilities
---@field formatter? false Disables configuration of auto-format on save
---@field derive_filetypes? false Disables derivation of additional filetypes from `pattern`
---@field default_filetypes? false Disables default fts from `lspconfig` being automatically added to configured fts.

---@param opts ConfigureLspOptions
function M.lsp(opts)
  ---@param args? table
  local callback = function(args)
    -- Run any pre-setup functions
    if opts.pre then
      opts.pre(args or {})
    end

    opts.config = opts.config or {}
    opts.config.filetypes = opts.config.filetypes or {}
    local config = opts.config

    -- Add capabilities to the config without overriding any existing config (unless explicitly disabled)
    if opts.capabilities ~= false then
      config.capabilities = require "cmp_nvim_lsp".default_capabilities(opts.config.capabilities or {})
    end

    -- Set up auto-format on save (unless explicitly disabled)
    if opts.formatter ~= false then
      local on_attach = require "lsp-format".on_attach

      if not opts.config.on_attach then
        config.on_attach = on_attach
      else
        local save = opts.config.on_attach
        config.on_attach = function(...)
          save(...)
          on_attach(...)
        end
      end
    end

    -- Derive filetypes from the pattern (unless explicitly disabled)
    if opts.derive_filetypes ~= false then
      for _, p in ipairs(type(opts.pattern) == "string" and { opts.pattern } or opts.pattern --[[ @as string[] ]]) do
        ---@diagnostic disable-next-line: need-check-nil
        table.insert(config.filetypes, (vim.filetype.match { filename = p }))
      end
    end

    -- Add default fts from lspconfig to configured fts (unless explicitly disabled)
    if opts.default_filetypes ~= false then
      for _, ft in ipairs(require "lspconfig"[opts.lsp].document_config.default_config.filetypes) do
        table.insert((config or {}).filetypes, ft)
      end
    end

    -- Set up the LSP server
    require "lspconfig"[opts.lsp].setup(config or {})

    -- Run any post-setup functions
    if opts.post then
      opts.post(args or {})
    end
  end

  if opts.pattern then
    vim.api.nvim_create_autocmd({ "BufNew", "BufNewFile", "BufReadPre" }, {
      group = "ConfigureLsp",
      once = true,
      pattern = opts.pattern,
      callback = function(args)
        callback(args)
        vim.schedule(vim.cmd.LspStart)
      end,
    })
  else
    callback()
  end
end

return setmetatable(M, mt)
