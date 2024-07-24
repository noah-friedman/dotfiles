local M = {}

local icons = {
  kind = {
    Text = "󱩾",
    Method = "󱝒",
    Function = "󰒓",
    Constructor = "󱉜",
    Field = "󱝔",
    Variable = "󰏫",
    Class = "󰀼",
    Interface = "󰠥",
    Module = "󰏖",
    Property = "󰓹",
    Unit = "",
    Value = "󰎠",
    Enum = "󰖽",
    Keyword = "",
    Snippet = "󰲋",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰝰",
    EnumMember = "󰈍",
    Constant = "󰏿",
    Struct = "󰉺",
    Event = "",
    Operator = "",
    TypeParameter = "",
  },
  source = {
    nvim_lsp = "",
    snippy = "󰆐",
  },
}

function M.setup()
  local cmp = require "cmp"
  local copilot = require "copilot.suggestion"

  cmp.setup {
    snippet = {
      expand = function(args)
        require "snippy".expand_snippet(args.body)
      end
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = {
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<Down>"] = cmp.mapping.select_next_item(),
      ["<ScrollWheelUp>"] = cmp.mapping.select_prev_item(),
      ["<ScrollWheelDown>"] = cmp.mapping.select_next_item(),
      ["<S-Up>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.scroll_docs(-1)
        else
          copilot.next()
        end
      end),
      ["<S-Down>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.scroll_docs(1)
        else
          copilot.prev()
        end
      end),
      ["<S-ScrollWheelUp>"] = cmp.mapping.scroll_docs(-1),
      ["<S-ScrollWheelDown>"] = cmp.mapping.scroll_docs(1),
      ["<CR>"] = cmp.mapping.confirm { select = true },
      ["<Tab>"] = cmp.mapping(function(fallback)
                                -- If the completion menu is open, select the next item
                                if cmp.visible() then
                                  cmp.select_next_item()
                                else
                                  fallback()
                                end
                              end, { "i", "s" }),
      ["<S-CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.close()
        end
        if copilot.is_visible() then
          copilot.accept()
        else
          fallback()
        end
      end),
      ["<S-BS>"] = cmp.mapping(function(fallback)
                                 if cmp.visible() then
                                   cmp.close()
                                 elseif require "copilot.suggestion".is_visible() then
                                   copilot.dismiss()
                                 else
                                   fallback()
                                 end
                               end, { "i", "s" }),
    },
    ---@diagnostic disable-next-line: missing-fields
    formatting = {
      format = function(entry, vim_item)
        vim_item.kind = string.format("%s  %-13s | %s", icons.kind[vim_item.kind],
                                      vim_item.kind,
                                      icons.source[entry.source.name])
        return vim_item
      end
    },
    sources = cmp.config.sources({
                                   { name = "lazydev", group_index = 0 },
                                   { name = "nvim_lsp" },
                                   { name = "otter" },
                                   { name = "snippy" },
                                 }, {
                                   { name = "nvim_lsp_signature_help" },
                                 }),
  }

  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
                                   { name = "git" }
                                 }, {
                                   { name = "buffer" },
                                 })
  })

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
                                   { name = "path" }
                                 }, {
                                   { name = "cmdline" }
                                 }),
    ---@diagnostic disable-next-line: missing-fields
    matching = { disallow_symbol_nonprefix_matching = false }
  })
end

return M
