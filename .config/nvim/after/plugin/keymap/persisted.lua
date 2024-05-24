for lhs, rhs in pairs {
  s = "SessionSave",
  l = "SessionLoadLast",
} do
  vim.keymap.set({ "n", "i", "v", "t" }, "<M-p>" .. lhs, "<Cmd>" .. rhs .. "<CR>", { noremap = true })
end
