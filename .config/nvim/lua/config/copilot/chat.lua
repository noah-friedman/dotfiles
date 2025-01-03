local M = {}

function M.setup()
  require "CopilotChat".setup {
    auto_insert_mode = true,
    window = {
      layout = "horizontal",
    },
    mappings = {
      submit_prompt = {
        normal = "<S-Enter>",
        insert = "<S-Enter>",
      }
    }
  }
end

return M
