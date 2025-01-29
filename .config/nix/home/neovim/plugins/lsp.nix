{ lib, ... }: {
  lsp = {
    enable = true;
    lazyLoad.settings.event = ["User FileOpened"];
    inlayHints = true;

    keymaps = {
      lspBuf = {
        "<F2>" = "rename";
        "<F3>" = "code_action";
      };
      extra = lib.mapAttrsToList (key: action: { inherit action key; mode = ["n" "i" "v"]; }) {
        # TODO -- FIX THIS
        "<F1>".__raw = ''function()
          ---@type vim.lsp.Client
          local client = vim.lsp.get_clients({
            name = "otter-ls[" .. vim.api.nvim_get_current_buf()  .. "]"
          })[1]
          if client then
            client.request(
              vim.lsp.protocol.Methods.textDocument_hover,
              vim.lsp.util.make_position_params(),
              function(e, r, c)
                if e or r then
                  vim.lsp.handlers.hover(e, r, c)
                end
                Result = { e, r, c }
                vim.lsp.handlers.hover(e, r, c)
              end
            )
            Requests = vim.deepcopy(client.requests)
            vim.notify(vim.inspect(Requests))
          end
        end'';
        "<F4>".__raw = ''function()
          require "telescope.builtin".lsp_definitions(require "telescope.themes".get_cursor {})
        end'';
      };
    };

    servers = {
      lua_ls = {
        enable = true;
        settings.diagnostics.disable = ["miss-name"];
      };
      nixd.enable = true;
    };
  };
  
  lazydev = {
    enable = true;
    lazyLoad.settings.event = ["User FileOpened"];

    settings = {
      library.__raw = ''(function()
        local path = vim.o.packpath:match("([^,]+)") .. "/pack/myNeovimPackages/"
        return { path .. "start", path .. "opt" }
      end)()'';
      integrations.cmp = true;
    };
  };
  lsp-format.enable = true;
  otter = {
    enable = true;
    lazyLoad.settings.event = "User FileOpened";

    settings = {
      handle_leading_whitespace = true;
    };
  };
}
