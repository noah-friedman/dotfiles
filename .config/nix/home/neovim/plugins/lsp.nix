{ ... }: {
  lsp = {
    enable = true;
    lazyLoad.settings.event = ["User FileOpened"];
    inlayHints = true;

    servers = {
      lua_ls = {
        enable = true;
        extraOptions.on_init.__raw = ''function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
              }
            }
          })
        end'';

        settings.diagnostics.disable = ["miss-name"];
      };
      nixd.enable = true;
    };
  };
  lsp-format.enable = true;
  otter.enable = true;
}
