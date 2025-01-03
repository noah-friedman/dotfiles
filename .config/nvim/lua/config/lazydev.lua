local M = {}

function M.setup()
  require "lazydev".setup {
    ---@param root_dir string
    ---@return boolean
    enabled = function(root_dir)
      local paths = {
        (function()
          local r = vim.fn.stdpath "config"
          if type(r) == "table" then
            r = r[1]
          end
          return r
        end)()
      }
      paths[2] = paths[1]:gsub("/nvim", "/local/nvim")

      for _, path in ipairs(paths) do
        if root_dir:find(path, 1, true) == 1 or require "util.devpath".match(root_dir) then
          return true
        end
      end
      return false
    end
  }
end

return M
