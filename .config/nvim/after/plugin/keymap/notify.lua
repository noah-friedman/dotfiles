vim.keymap.set("n", "<A-n>", function()
  require "notify".dismiss { pending = false, silent = false }
end)
