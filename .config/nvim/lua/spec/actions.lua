local configure = require "util.configure"

return {
  {
    "famiu/bufdelete.nvim",
    cmd = "Bdelete",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function() require "telescope".load_extension "fzf" end,
      },
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Telescope",
    config = configure "telescope",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
    },
    cmd = "Telescope file_browser",
    config = function() require "telescope".load_extension "file_browser" end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    init = function()
      local save = vim.ui.select
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(items, opts, on_choice)
        vim.ui.select = save
        require "telescope".load_extension "ui-select"
        vim.ui.select(items, opts, on_choice)
      end
    end,
    lazy = true,
  },
  {
    "smjonas/inc-rename.nvim",
    dependencies = {
      {
        "stevearc/dressing.nvim",
      },
    },
    opts = {
      input_buffer_type = "dressing",
    },
    lazy = true,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = ":call mkdp#util#install()",
  },
  {
    "tpope/vim-fugitive",
    dependencies = {
      {
        "seanbreckenridge/yadm-git.vim",
        config = function() vim.g.yadm_git_gitgutter_enabled = 0 end,
      },
    },
    cmd = "Git",
  },
  {
    "speelbarrow/spLauncher.nvim",
    config = true,
    event = "User FileOpened",
  },
}
