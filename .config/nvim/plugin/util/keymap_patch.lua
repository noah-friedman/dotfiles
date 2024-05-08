if vim.fn.has "macunix" == 1 then
  vim.keymap._set = vim.keymap.set
  ---@param mode string|string[]
  ---@param lhs string
  ---@param rhs string|function
  ---@param opts vim.keymap.set.Opts
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.keymap.set = function(mode, lhs, rhs, opts)
    vim.keymap._set(mode, lhs:gsub("^<C%-([^c])", "<D-%1"), rhs, opts)
  end
end
