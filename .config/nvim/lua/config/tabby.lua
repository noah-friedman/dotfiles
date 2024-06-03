local M = {}

function M.setup()
  require "tabby".setup()

  require "tabby.presets".active_wins_at_tail.head[1][1] = "  "
  local ll_theme = require "config.lualine".theme
  local theme = {
    fill = ll_theme.normal.c,
    head = ll_theme.visual.a,
    current_tab = ll_theme.normal.a,
    tab = ll_theme.normal.b,
    win = ll_theme.normal.b,
    tail = ll_theme.normal.b,
  }
  local left_sep = ""
  local right_sep = ""

  require "tabby.tabline".set(function(line)
    return {
      {
        { "  ", hl = theme.head },
        line.sep(right_sep, theme.head, theme.fill),
      },
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab
        local status_icon = { "", "󰆣" }
        return {
          line.sep(left_sep, hl, theme.fill),
          tab.is_current() and status_icon[1] or status_icon[2],
          tab.number(),
          tab.name(),
          tab.close_btn "",
          line.sep(right_sep, hl, theme.fill),
          hl = hl,
          margin = " ",
        }
      end),
      line.spacer(),
      line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
        local status_icon = { "", "" }
        return {
          line.sep(left_sep, theme.win, theme.fill),
          win.is_current() and status_icon[1] or status_icon[2],
          win.buf_name(),
          line.sep(right_sep, theme.win, theme.fill),
          hl = theme.win,
          margin = " ",
        }
      end),
      {
        line.sep(left_sep, theme.tail, theme.fill),
        { "  ", hl = theme.tail },
      },
      hl = theme.fill,
    }
  end)
end

return M
