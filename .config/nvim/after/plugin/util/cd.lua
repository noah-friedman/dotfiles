function Cd()
  vim.cmd.cd "%:p:h"
end

vim.api.nvim_create_user_command("Cd", Cd, {})
