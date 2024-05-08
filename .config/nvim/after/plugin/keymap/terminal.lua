vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set("t", "<S-Esc>", function()
                 vim.fn.chansend(vim.b.terminal_job_id, vim.api.nvim_replace_termcodes("<Esc>", true, false, true))
               end, { noremap = true })
