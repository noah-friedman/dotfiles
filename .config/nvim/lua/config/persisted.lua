local M = {}

function M.setup()
  require "persisted".setup {
    autosave = false,
    use_git_branch = true,
  }
  require "telescope".load_extension "persisted"
end

return M
