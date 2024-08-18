local buf = vim.api.nvim_get_current_buf()

---@type spLauncher.ActionMap
vim.b[buf].spLauncherActionMap = {
  base = "rustc",
  run = function()
    local temp = vim.fn.tempname()
    return "-o " .. temp .. " % && " .. temp
  end,
  debug = {
    handler = function()
      local temp = vim.fn.tempname()
      return "-g -o " .. temp .. " % && rust-lldb " .. temp
    end,
    config = {
      window = {
        focus = "insert",
        persist = false,
      },
    },
  },
  test = function()
    local temp = vim.fn.tempname()
    return "--test -o " .. temp .. " % && " .. temp
  end,
  build = "%",
}

if #vim.fs.find("Cargo.toml", { upward = true, path = vim.fn.expand "%:p:h" }) > 0 then
  vim.b.spLauncherActionMap = vim.tbl_deep_extend("force", vim.b.spLauncherActionMap, {
    base = "cargo",
    run = true,
    debug = true,
    test = true,
    build = true,
    clean = true,
  })
end
