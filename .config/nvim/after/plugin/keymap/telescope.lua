local prefix = "<M-v>"
vim.keymap.set({ "n", "i", "v" }, prefix, "<Cmd>Telescope<CR>")

local file_browser = require "util.file_browser"

for key, picker in pairs {
  b = file_browser(false),
  B = file_browser(true),
  f = "find_files",
  F = "find_files cwd=%:p:h",
  o = "oldfiles",
  p = "projects",
  n = "notify",
  H = "highlights",
  g = "builtin default_text=git",
  a = "autocommands",
  r = "live_grep",
  m = "keymaps",
  v = "vim_options",
  s = function()
    require "telescope.builtin".symbols { sources = { "emoji", "math", "nerd" } }
  end,
  h = "help_tags",
  d = "diagnostics bufnr=0",
  D = "diagnostics",
  c = function()
    local t = require "CopilotChat.actions".prompt_actions() or { actions = {} }
    t.prompt = "Copilot Chat"
    t.actions["Explain diagnostic"] = {
      prompt = 'Please explain the following diagnostic issue in file: "',
      selection = require "CopilotChat.select".diagnostics,
    }
    t.actions["Fix diagnostic"] = t.actions["FixDiagnostic"]
    t.actions["FixDiagnostic"] = nil
    t.actions["Commit staged"] = t.actions["CommitStaged"]
    t.actions["CommitStaged"] = nil
    require "CopilotChat.integrations.telescope".pick(t)
  end,
  ["<Enter>"] = "resume"
} do
  vim.keymap.set({ "n", "i", "v" }, prefix .. key, (type(picker) == "string") and ("<Cmd>Telescope " .. picker .. "<CR>")
    or picker)
end
