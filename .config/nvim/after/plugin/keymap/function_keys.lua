local loadedIncRename = false
local function_maps = {
  vim.lsp.buf.hover,
  function()
    if #(vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf(), name = "custom_elements_ls" }) > 0 then
      vim.lsp.buf.rename()
    else
      if not loadedIncRename then
        require "lazy".load {
          plugins = {
            "inc-rename.nvim"
          }
        }
        loadedIncRename = true
      end
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>:IncRename " .. vim.fn.expand "<cword>", true, false,
                                                           true),
                            "n", false)
    end
  end,
  vim.lsp.buf.code_action,
  function()
    require "telescope.builtin".lsp_definitions(require "telescope.themes".get_cursor {})
  end,
  vim.diagnostic.open_float,
  vim.cmd.noh,
  function()
    require "copilot.suggestion".toggle_auto_trigger()
  end,
  function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 })
  end,
  function()
    vim.wo.spell = not vim.wo.spell
  end,
}

for index, mapping in ipairs(function_maps) do
  vim.keymap.set({ "n", "i", "v" }, "<F" .. index .. ">", (type(mapping) == "function") and mapping or mapping[1],
                 { noremap = true })
  if type(mapping) == "table" and mapping[2] then
    vim.keymap.set({ "n", "i", "v" }, "<S-F" .. index .. ">", mapping[2], { noremap = true })
  end
end
