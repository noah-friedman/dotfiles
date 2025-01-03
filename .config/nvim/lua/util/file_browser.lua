---@param current boolean
return function(current)
  return function()
    require "lazy".load {
      plugins = { "telescope-file-browser.nvim" },
    }
    require "telescope".extensions.file_browser.file_browser {
      hidden = true,
      respect_gitignore = true,
      path = current and vim.fn.expand "%:p:h" or nil,
    }
  end
end
