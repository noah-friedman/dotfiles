vim.api.nvim_create_augroup("Sessions", {})

vim.api.nvim_create_autocmd("User", {
  group = "Sessions",
  pattern = "PersistedSavePre",
  command = "ScopeSaveState",
})

vim.api.nvim_create_autocmd("SessionLoadPost", {
  group = "Sessions",
  command = "ScopeLoadState",
})

vim.api.nvim_create_autocmd("User", {
  group = "Sessions",
  pattern = { "PersistedLoadPost", "PersistedTelescopeLoadPost" },
  command = "ScopeLoadState",
})
