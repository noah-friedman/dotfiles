return function()
  local roots = vim.fs.find("Cargo.toml", { upward = true, path = vim.fn.expand "%:p:h" })
  if #roots > 0 then
    vim.b.spLauncherActionMap = vim.tbl_deep_extend("force", vim.b.spLauncherActionMap or {}, {
      base = "cargo",
      run = function()
        local stripped = roots[1]:gsub("/Cargo%.toml$", "")
        local path = (vim.fn.expand "%:p"):gsub("^" .. stripped, "")
        local name, count = path:gsub("^/examples/", "")
        if count == 0 then
          return "r"
        else
          return "r --example=" .. name:gsub("%.rs$", "")
        end
      end,
      debug = "d",
      test = "t",
      build = "b",
      clean = "c",
    })
  end
end
