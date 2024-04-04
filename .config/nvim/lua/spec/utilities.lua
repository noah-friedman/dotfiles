local filetypes = {
  "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx", "jsx", "rescript",
  "xml", "php", "markdown", "astro", "glimmer", "handlebars", "hbs", "svg",
}


function _G.close_tag()
  require "nvim-ts-autotag".update()
end

return {
  {
    "ahmedkhalf/project.nvim",
    config = function() require "config.project".setup() end,
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
