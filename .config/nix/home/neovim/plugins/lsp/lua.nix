{ ... }: {
  lua_ls = {
    enable = true;
    extraOptions.on_init.__raw = ''function(client)          
      local path = vim.o.packpath:match("([^,]+)") .. "/pack/myNeovimPackages/"

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = "LuaJIT"
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            path .. "start",
            path .. "opt",
          },
        },
      })
    end'';
    settings.diagnostics.disable = ["miss-name"];
  };
}
