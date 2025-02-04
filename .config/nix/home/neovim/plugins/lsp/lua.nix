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
    settings = {
      completion.showWord = "Disable";
      format = {
        enabled = true;
        defaultConfig = {
          align_call_args = "true";
          align_function_params = "true";
          align_continuous_rect_table_field = "true";
          align_if_branch = "true";
          call_arg_parentheses = "remove";
          indent_style = "space";
          indent_size = "2";
          quote_style = "double";
        };
      };
      hint.enable = true;
    };
  };
}
