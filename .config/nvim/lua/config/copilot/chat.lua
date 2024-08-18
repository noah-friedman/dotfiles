local M = {}

function M.setup()
  require "CopilotChat".setup {
    auto_insert_mode = true,
    window = {
      layout = "float",
    },
    mappings = {
      submit_prompt = {
        normal = "<A-CR>",
        insert = "<A-CR>",
      }
    }
  }
end

return M
