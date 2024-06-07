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
---@field config? table | (fun(args: table): table)
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
    local lspconfig = require "lspconfig"

    -- Run any pre-setup functions
    if opts.pre then
      opts.pre(args or {})
    end

    if type(opts.config) == "function" then
      opts.config = opts.config(args or {})
    end
    opts.config = opts.config or {}
    opts.config.filetypes = opts.config.filetypes or {}
    local config = opts.config --[[ @as table ]]

    -- Add capabilities to the config without overriding any existing config (unless explicitly disabled)
    if opts.capabilities ~= false then
      config.capabilities = vim.tbl_deep_extend("keep", opts.config.capabilities or {},
                                                require "cmp_nvim_lsp".default_capabilities())
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
      for _, ft in ipairs(lspconfig[opts.lsp].document_config.default_config.filetypes) do
        table.insert(config.filetypes, ft)
      end
    end

    -- Remove duplicates from configured filetypes
    local filetypes = vim.deepcopy(config.filetypes or {})
    config.filetypes = {}
    local seen = {}
    for _, ft in ipairs(filetypes) do
      if not seen[ft] then
        table.insert(config.filetypes, ft)
        seen[ft] = true
      end
    end

    -- Set up the language server
    if opts.lsp == "sourcekit" then
      Config = vim.deepcopy(config)
    end
    lspconfig[opts.lsp].setup(config)

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

---@param bufnr integer
---@param opts table
local function wo_callback(bufnr, opts)
  for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
    vim.schedule(function()
      local result, msg = pcall(function()
        for key, value in pairs(opts) do
          vim.wo[win][key] = value
        end
      end)
      if not result and not msg --[[ @as string ]]:match "Invalid window id: [0-9]+$" then
        vim.notify("While (un)setting window options:\n" .. msg, vim.log.levels.ERROR)
      end
    end)
  end
end

---@param opts function(on: boolean): table
---@param event string
---@param pattern? string
---@param off_events? string[]
function M.wo(opts, event, pattern, off_events)
  vim.api.nvim_create_autocmd(event, {
    pattern = pattern,
    callback = function(args)
      wo_callback(args.buf, opts(true))
      vim.api.nvim_create_autocmd({ "BufEnter", "BufUnload", table.unpack(off_events or {}) }, {
        buffer = args.buf,
        callback = function(args2)
          wo_callback(args2.buf, opts(args2.event == "BufEnter"))
        end
      })
    end
  })
end

return setmetatable(M, mt)
