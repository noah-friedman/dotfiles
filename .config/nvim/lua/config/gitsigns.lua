local M = {}

function M.setup()
  local gitsigns = require "gitsigns"

  gitsigns.setup {
    ---@param callback function
    _on_attach_pre = function(_, callback)
      require "gitsigns-yadm".yadm_signs(callback)
    end,
    ---@param bufnr number
    on_attach = function(bufnr)
      if vim.b[bufnr].gitsigns_status_dict.gitdir == vim.fn.stdpath "data" --[[ @as string ]]:gsub("/nvim",
                                                                                                   "") .. "/yadm/repo.git" and vim.fn["fugitive#Head"]() == "" then
        vim.schedule(function() gitsigns.detach(bufnr) end)
      end
    end,
    attach_to_untracked = true,
    numhl = true,
    preview_config = {
      border = "rounded",
    },
  }
end

return M
