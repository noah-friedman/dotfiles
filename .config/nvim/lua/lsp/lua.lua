Activated = {}
require "util.configure".lsp {
  lsp = "lua_ls",
  pattern = "*.lua",
  config = {
    settings = {
      Lua = {
        completion = {
          showWord = "Disable",
        },
        diagnostics = {
          globals = { "vim" },
          neededFileStatus = {
            ["codestyle-check"] = "Any"
          },
        },
        format = {
          enabled = true,
          defaultConfig = {
            align_call_args = "true",
            align_function_params = "true",
            align_continuous_rect_table_field = "true",
            align_if_branch = "true",
            call_arg_parentheses = "remove",
            indent_style = "space",
            indent_size = "2",
            quote_style = "double",
          },
        },
        hint = {
          enable = true,
        },
        workspace = {
          checkThirdParty = false,
          library = { vim.api.nvim_get_runtime_file("", true) },
        },
      }
    }
  },
}
