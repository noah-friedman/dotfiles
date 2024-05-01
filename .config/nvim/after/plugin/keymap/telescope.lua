local prefix = "<M-v>"
vim.keymap.set({ "n", "i", "v" }, prefix, "<Cmd>Telescope<CR>")

for key, picker in pairs {
  b = "file_browser",
  l = "file_browser path=%:p:h",
  o = "oldfiles",
  p = "projects",
  n = "notify",
  h = "highlights",
  g = "git_status",
  a = "autocommands",
  r = "resume",
  k = "keymaps",
  v = "vim_options",
} do
  vim.keymap.set({ "n", "i", "v" }, prefix .. key, "<Cmd>Telescope " .. picker .. "<CR>")
end
