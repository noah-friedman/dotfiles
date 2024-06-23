vim.keymap.set("n", "<A-c>", function()
  require "notify".dismiss { pending = false, silent = false }
end)
