{ ... }: [
  {
    callback.__raw = ''function(args)
      local callback = function(args, disable)
        local winid = vim.fn.win_findbuf(args.buf)[1]
        for option, value in pairs {
          number = disable ~= true,
          signcolumn = disable ~= true and "yes" or "no",
          wrap = disable ~= true,
        } do
          vim.notify(vim.fn.join({args.event, args.buf, winid, option, value}, " "), vim.log.levels.TRACE)
          if winid ~= nil and vim.wo[winid] ~= nil then
            vim.wo[winid][option] = value
          end
        end
      end
      callback(args, true)
      vim.api.nvim_create_autocmd("BufWinEnter", {
        buffer = args.buf,
        callback = function(args) callback(args, true) end
      })
      vim.api.nvim_create_autocmd("BufWinLeave", {
        buffer = args.buf,
        callback = callback,
        once = true,
      })
    end'';
    event = "TermOpen";
    nested = true;
  }
]
