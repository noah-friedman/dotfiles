{ ... }: [
  {
    callback.__raw = ''function() 
      vim.api.nvim_exec_autocmds("User", {
        pattern = "FileOpened",
      })
    end'';
    event = ["BufReadPre" "BufNewFile"];
  }
]
