{ mode, ... }: [
  {
    action = "<Cmd>sp +terminal<CR>i";
    key = "<M-t>";
    inherit mode;
  }
  {
    action = "<Cmd>terminal<CR>i";
    key = "<M-T>";
    inherit mode;
  }
  {
    action = ''<C-\><C-n>'';
    key = "<Esc>";
    mode = "t";
  }
  {
    action = ''function()
      vim.fn.chansend(
        vim.b.terminal_job_id,
        vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
      )
    end'';
    key = "<S-Esc>";
    mode = "t";
  }
]
