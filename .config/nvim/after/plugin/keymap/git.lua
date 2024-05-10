local leader = "<M-g>"

---@param command string
---@param fallback_command? string
---@return function
local function telescope_fallback(command, fallback_command)
  return function()
    fallback_command = fallback_command or command

    if not pcall(vim.cmd.Telescope, "git_" .. command) then
      vim.cmd("Git " .. fallback_command)
    end
  end
end

---@param description string
---@param action string|function
---@return function
local function warn_wrap(description, action)
  return function()
    require "lazy".load { plugins = { "dressing.nvim" } }
    vim.ui.input({
                   prompt = ("You are about to execute the following action: '" .. description .. "'. Are you sure y" ..
                     "ou want to continue? [y/N] "),
                 },
      ---@param input? string
                 function(input)
                   if input and input:lower():sub(1, 1) == "y" then
                     if type(action) == "string" then
                       vim.cmd(action)
                     else
                       action()
                     end
                   end
                 end)
  end
end

for mapping, action in pairs {
  a = {
    "Gitsigns stage_hunk",
  },
  r = {
    warn_wrap("reset hunk", "Gitsigns reset_hunk"),
  },
  u = "Gitsigns undo_stage_hunk",
  d = {
    "Gitsigns preview_hunk",
  },
  c = "tab Git commit",
  p = "Git push",
  x = function()
    vim.cmd "tab Git commit"
    vim.api.nvim_create_autocmd("User", {
      pattern = "FugitiveChanged",
      once = true,
      command = "Git push"
    })
  end,
  t = "Git push --tags",
  s = telescope_fallback "status",
  b = telescope_fallback("branches", "branch"),
  l = telescope_fallback("commits", "log"),
  L = telescope_fallback("bcommits", "log %"),
  A = "Gitsigns stage_buffer",
  R = warn_wrap("reset buffer", "Gitsigns reset_buffer"),
  C = warn_wrap("amend commit", "tab Git commit --amend"),
  P = warn_wrap("force push", "Git push -f"),
  X = warn_wrap("amend commit and force push", function()
    vim.cmd "tab Git commit --amend"
    vim.api.nvim_create_autocmd("User", {
      pattern = "FugitiveChanged",
      once = true,
      command = "Git push -f"
    })
  end),
  ["<C-a>"] = "Git add .",
  ["<C-x>"] = function()
    vim.cmd "Git add ."
    vim.cmd "tab Git commit"
    vim.api.nvim_create_autocmd("User", {
      pattern = "FugitiveChanged",
      once = true,
      command = "Git push"
    })
  end,
} do
  if type(action) == "table" then
    vim.keymap.set("v", leader .. mapping, (type(action[1]) == string) and ("<Cmd>'<,'>" .. action[1] .. "<CR>") or
      action[1])
    action = action[1]
  end
  vim.keymap.set({ "n", "i" }, leader .. mapping, type(action) == "string" and ("<Cmd>" .. action .. "<CR>") or action)
end
