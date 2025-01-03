vim.schedule(function()
  if vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t") == "Cargo.toml" then
    vim.schedule_wrap(require "util.cargo")()
  end
end)
