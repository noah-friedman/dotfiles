local M = {}

local colors = require "dracula".colors()
M.theme = require "lualine.themes.dracula-nvim"
for mode, _ in pairs(M.theme) do
  local fg = M.theme[mode].b.fg
  M.theme[mode].b = { fg = colors["bright_white"], bg = colors["selection"] }
  if not M.theme[mode].c then
    M.theme[mode].c = { fg = fg, bg = colors["black"] }
  else
    M.theme[mode].c.fg = fg
  end
end

M.theme["inactive"].c.fg = "white"


function M.setup()
  -- Disable the default mode display
  vim.o.showmode = false

  require "lualine".setup {
    options = {
      theme = M.theme,
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        "mode",
      },
      lualine_b = {
        "branch",
        "diff"
      },
      lualine_c = {
        {
          "buffers",
          show_filename_only = false,
          symbols = {
            alternate_file = "",
            directory = "󰉖 ",
          },
          use_mode_colors = true,
        }
      },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_lsp" },
          sections = { "error", "warn", "info", "hint" },
          symbols = {
            error = "󱎘 ",
            warning = "󱈸 ",
            info = " ",
            hint = "󰙴 ",
          }
        },
        {
          "(vim.b.copilot_suggestion_auto_trigger == false) and ' ' or ' '",
          color = { fg = colors["white"] }
        }
      },
      lualine_y = {
        "filetype",
        "o:shiftwidth",
        "fileformat",
        "encoding",
      },
      lualine_z = {
        "progress",
        "location",
      }
    },
  }

  -- listen lsp-progress event and refresh lualine
  vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = "lualine_augroup",
    pattern = "LspProgressStatusUpdated",
    callback = require "lualine".refresh,
  })
end

return M
