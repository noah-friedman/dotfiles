local M = {}

function M.setup()
  vim.opt.rtp --[[ @as vim.Option ]]:prepend(vim.fn.stdpath "data" .. "/lazy/lazy.nvim")

  local lpath = vim.fn.stdpath "config" --[[ @as string ]]:gsub("nvim$", "local/nvim")
  vim.opt.rtp:prepend(lpath)
  vim.opt.rtp:prepend(lpath .. "/after")

  require "lazy".setup {
    dev = {
      pcall(require, "devpath") and table.unpack(require "devpath") or nil,
      fallback = true,
    },
    spec = {
      -- Synced spec
      vim.iter(ipairs(require "util.require_dir" "spec")):map(function(_, value)
        return table.unpack(value)
      end):totable(),

      -- Local spec
      vim.iter(ipairs(require "util.require_dir" ("spec", vim.fn.stdpath "config" --[[ @as string ]]:gsub(
        "nvim$", "local/nvim/lua/")))):map(function(_, value)
        return table.unpack(value)
      end):totable(),
    },
    install = {
      colorscheme = { "dracula" }
    },
    performance = {
      rtp = {
        paths = {
          lpath,
          lpath .. "/after",
        },
      },
    },
    checker = {
      enabled = true,
      concurrency = #vim.loop.cpu_info(),
    },
    change_detection = {
      enabled = true,
      notify = true,
    },
  }
end

return M
