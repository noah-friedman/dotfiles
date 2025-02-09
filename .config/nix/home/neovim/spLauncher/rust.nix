{ ... }: {
  base = "rustc";
  run.__raw = ''function()
    local temp = vim.fn.tempname()
    return "-o " .. temp .. " % && " .. temp
  end'';
  debug = {
    handler.__raw = ''function()
      local temp = vim.fn.tempname()
      return "-g -o " .. temp .. " % && rust-lldb " .. temp
    end'';
    config = {
      window = {
        focus = "insert";
        persist = false;
      };
    };
  };
  test.__raw = ''function()
    local temp = vim.fn.tempname()
    return "--test -o " .. temp .. " % && " .. temp
  end'';
  build = "%";
  __raw = ''
    local root = vim.fs.root(0, { 'Cargo.toml' })
    if root ~= nil then
      vim.b.spLauncherActionMap = vim.tbl_deep_extend("force", vim.b.spLauncherActionMap or {}, {
        base = "cargo",
        run = function()
          local stripped = root:gsub("/Cargo%.toml$", "")
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
        Run = function()
          return (vim.b.spLauncherActionMap.run() .. " --release")
        end,
        Debug = "d --release",
        Test = "t --release",
        Build = "b --release",
        Clean = "c --release"
      })
    end
  '';
}
