local M = {}

local filetypes = {
  "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx", "jsx", "rescript",
  "xml", "php", "markdown", "astro", "glimmer", "handlebars", "hbs", "svg",
}

function M.setup()
  ---@diagnostic disable-next-line: missing-fields
  require "nvim-treesitter.configs".setup {
    autotag = {
      enable = true,
      enable_rename = true,
      enable_close = true,
      enable_close_on_slash = true,
      filetypes = filetypes,
    },
  }
end

return M
