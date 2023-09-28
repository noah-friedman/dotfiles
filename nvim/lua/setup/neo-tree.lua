local M = {}

---@return integer
local function calculate_width()
    return math.min(49, vim.o.co - vim.bo.textwidth - 6)
end

function M.setup()
    -- Load Netman
    require'netman'

    vim.fn.sign_define("DiagnosticSignError" ,{text = " ", texthl = "DiagnosticSignError"})
    vim.fn.sign_define("DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
    vim.fn.sign_define("DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
    vim.fn.sign_define("DiagnosticSignHint", {text = "󰌵", texthl = "DiagnosticSignHint"})

    -- Configure custom icons for nvim-web-devicons		
    require'nvim-web-devicons'.setup {
        override = {
            go = {
                icon = '󰟓',
                color = "#519aba",
                cterm_color = "74",
                name = "Go",
            },
            ["gohtml"] = {
                icon = '󰟓',
                color = "#519aba",
                cterm_color = "74",
                name = "GoHTML",
            },
            ["go.mod"] = {
                icon = '󰟓',
                color = "#519aba",
                cterm_color = "74",
                name = "GoModules",
            },
        }
    }

    require"neo-tree".setup {
        close_if_last_window = true,
        default_component_configs = {
            indent = {
                indent_size = 2,
                padding = 0,
            },
            icon = {
                folder_closed = "+",
                folder_open = "-",
            },
            file_size = { enabled = false },
            last_modified = { enabled = false },
            created = { enabled = false },

            type = {
                enabled = true,
                required_width = 32
            },
        },
        sources = {
            "filesystem",
            "buffers",
            "git_status",
            "netman.ui.neo-tree"
        },
        source_selector = {
            winbar = true,
            content_layout = "center",
            tabs_layout = "equal",
            show_seperator_on_edge = true,
            sources = {
                {
                    source = "filesystem",
                    display_name = "󰉓"
                },
                {
                    source = "buffers",
                    display_name = "󰈚"
                },
                {
                    source = "git_status",
                    display_name = "󰊢"
                },
                {
                    source = "remote",
                    display_name = "󰱠"
                }
            }
        },
        window = {
            width = math.min(49, vim.o.columns - vim.o.textwidth - 5),
            mappings = {
                ["<Tab>"] = function()
                    vim.cmd.wincmd 'w'
                end,
                ["A"] = "git_add_file",
                ["D"] = "git_unstage_file",
                ["<C-d>"] = "git_revert_file",
                ["<S-Left>"] = "prev_source",
                ["<S-Right>"] = "next_source",
                ["<C-x>"] = "noop",
            }
        },
        filesystem = {
            use_libuv_file_watcher = true,
            follow_current_file = {
                enabled = true
            },
            filtered_items = {
                hide_gitignored = true,
                hide_by_name = {
                    "node_modules",
                },
                always_show = {
                    ".gitignore",
                    ".github",
                },
            }
        },
        event_handlers = {
            {
                event = "neo_tree_window_after_open",
                handler = function(args)
                    vim.wo[args.winid].number = false
                end
            }
        },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "VimResized" }, {
        callback = function(args)
            if vim.bo[args.buf].filetype == "neo-tree" then return end

            local state = M.get_state()
            if state ~= nil then
                local width = calculate_width()
                state.window.width = width
                vim.api.nvim_win_set_width(state.winid, width)
            end
        end
    })

    vim.keymap.set('n', '<Tab>', '<Cmd>Neotree action=focus source=last<CR>')
    vim.keymap.set('n', '<S-Tab>', function()
        if M.get_state() ~= nil then
            vim.cmd.Neotree "close"
        else
            vim.cmd.Neotree "show"
        end
    end)

    vim.api.nvim_create_autocmd("BufEnter", {
        callback = function(args)
            if M.get_state() == nil and require'project_nvim.project'.get_project_root() ~= nil then
                for _, filetype in ipairs({ "help", "gitcommit", "git", "neo-tree" }) do
                    if vim.bo[args.buf].filetype == filetype then
                        return
                    end
                end
                vim.cmd.Neotree "show"
            end
        end
    })
end

function M.get_state()
    for _, source in ipairs({ "filesystem", "buffers", "git_status" }) do
        local source_state = require'neo-tree.sources.manager'.get_state(source)
        if require'neo-tree.ui.renderer'.tree_is_visible(source_state) then
            return source_state
        end
    end
end

return M
