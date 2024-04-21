require "util.configure_lsp" ("lua_ls", "*.lua", {
                                settings = {
                                  Lua = {
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
                              }, function(_)
                                require "neodev".setup {
                                  ---@param root_dir string
                                  ---@param library table
                                  override = function(root_dir, library)
                                    local paths = {
                                      (function()
                                        local r = vim.fn.stdpath "config"
                                        if type(r) == "table" then
                                          r = r[1]
                                        end
                                        return r
                                      end)()
                                    }
                                    paths[2] = paths[1]:gsub("/nvim", "/local/nvim")

                                    for _, path in ipairs(paths) do
                                      if root_dir:find(path, 1, true) == 1 or (pcall(require, "devpath") and root_dir:find(require "devpath".path, 1, true) == 1) then
                                        library.enabled = true
                                        library.runtime = true
                                        library.types = true
                                        library.plugins = true
                                        return
                                      end
                                    end
                                  end
                                }
                              end)
