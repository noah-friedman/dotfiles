return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "neovim/nvim-lspconfig",
                config = function()
                    require"lsp"
                end,
            },
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            {
                "dcampos/nvim-snippy",
                dependencies = {
                    "dcampos/cmp-snippy",
                    "honza/vim-snippets",
                },
                lazy = true,
            },
            {
                "zbirenbaum/copilot.lua",
                config = function() require"config.copilot".setup() end
            }
        },
        priority = 400,
        config = function() require"config.cmp".setup() end
    },
    --[[{
        "ms-jpq/coq.nvim",
        lazy = true,
        init = function()
            vim.g.coq_settings = vim.tbl_deep_extend("keep", vim.g.coq_settings or {}, {
                auto_start = true,
            })
        end,
        build = function()
            vim.cmd "COQdeps"
        end,
    },]]

    -- Copilot

    -- Extension to LuaLS that makes it aware of Neovim runtime files
    {
        "folke/neodev.nvim",
        lazy = true,
    },

    -- Rust LSP and other goodies
    {
        "mrcjkb/rustaceanvim",
        dependencies = {
            "rust-lang/rust.vim",
            {
                "Saecki/crates.nvim",
                dependencies = {
                    "nvim-lua/plenary.nvim",
                },
            },
        },
        -- Configuration found in `lsp/rust.lua`
        ft = "rust",
    },
    {
        "Saecki/crates.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",

            -- Loads `rustaceanvim` for the non-LSP features it provides
            {
                "mrcjkb/rustaceanvim",
                dependencies = {
                    "rust-lang/rust.vim"
                },
            }
        },
        event = "BufRead *Cargo.toml",
        config = true
    },
}
