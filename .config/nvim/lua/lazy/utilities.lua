local filetypes = {
    'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
    'xml', 'php', 'markdown', 'astro', 'glimmer', 'handlebars', 'hbs', 'svg',
}


return {
    {
        "ahmedkhalf/project.nvim",
        config = function() require"config.project".setup() end,
        priority = 450,
    },
    {
        "PriceHiller/nvim-ts-autotag",
        branch = "fix/close-xml-tags",
        ft = filetypes,
        opts = {
            filetypes = filetypes
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        },
    },
}
