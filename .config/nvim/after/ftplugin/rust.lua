local buf = vim.api.nvim_get_current_buf()

---@module "spLauncher"
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


local roots = vim.fs.find("Cargo.toml", { upward = true, path = vim.fn.expand "%:p:h" })
if #roots > 0 then
  vim.b.spLauncherActionMap = vim.tbl_deep_extend("force", vim.b.spLauncherActionMap, {
    base = "cargo",
    run = function()
      local stripped = roots[1]:gsub("/Cargo%.toml$", "")
      local path = (vim.fn.expand "%:p"):gsub("^" .. stripped, "")
      local name, count = path:gsub("^/examples/", "")
      if count == 0 then
        return true
      else
        return "run --example=" .. name:gsub("%.rs$", "")
      end
    end,
    debug = true,
    test = true,
    build = true,
    clean = true,
  })
end
