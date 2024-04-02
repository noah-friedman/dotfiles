require"util.configure_lsp"("yamlls", { "*.yml", "*.yaml" }, {
    settings = {
        yaml = {
            schemaStore = {
                enable = true,
            },
        },
    },
})
