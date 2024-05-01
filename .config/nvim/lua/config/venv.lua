local M = {}

function M.setup()
  require "venv-selector".setup {
    changed_venv_hooks = {
      function(_, _)
        vim.schedule_wrap(vim.cmd.LspRestart)()
      end,
      require "venv-selector.hooks".pylsp_hook,
    }
  }
end

return M
