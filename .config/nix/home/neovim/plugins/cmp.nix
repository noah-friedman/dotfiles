{ ... }: let
  makeMapping = mode: maps: builtins.mapAttrs (n: v: "{ ${mode} = ${v} }") ({
    "<CR>" = "cmp.mapping.confirm({ select = ${if mode != "c" then "true" else "false"} })";
    "<S-BS>" = ''function()
      if cmp.visible_docs() then
        cmp.close_docs()
      else
        cmp.mapping.abort()
      end
    end'';
  } // maps);
  selectors = If: Else: prev: let
  r = ''function(fallback)
      ${If prev}
        cmp.select_${if prev then "prev" else "next"}_item()
      else
        ${Else}
      end
    end'';
  in r;
in {
  cmp = {
    enable = true;
    lazyLoad.settings.event = ["User FileOpened" "CmdlineEnter"];

    settings = {
      sources = [
        {
          name = "nvim_lsp";
          group_index = 1;
        }
        {
          name = "treesitter";
          group_index = 2;
        }
        {
          name = "snippy";
          group_index = 2;
        }
        {
          name = "nvim_lsp_signature_help";
          group_index = 3;
        }
      ];

      mapping = let
        arrows = prev: selectors (prev: ''
        if cmp.visible_docs() then
          cmp.scroll_docs(${if prev then "-1" else "1"})
        elseif cmp.visible() then
        '') "fallback()" prev;
        tabs = prev: selectors (prev: "if cmp.visible() then") "fallback()" prev;
      in makeMapping "i" {
        "<Up>" = arrows true;
        "<Down>" = arrows false;
        "<ScrollWheelUp>" = arrows true;
        "<ScrollWheelDown>" = arrows false;
        "<Tab>" = tabs false;
        "<S-Tab>" = tabs true;
        "<S-Up>" = tabs true;
        "<S-Down>" = tabs false;
        "<S-ScrollWheelUp>" = tabs true;
        "<S-ScrollWheelDown>" = tabs false;
        "<S-CR>" = ''function()
          if cmp.visible_docs() then
            cmp.close_docs()
          elseif cmp.visible() then
            cmp.open_docs()
          else
            cmp.complete()
          end
        end'';
      };

      view.docs.auto_open = false;

      window = rec {
        completion.__raw = "cmp.config.window.bordered()";
        documentation = completion;
      };

      formatting.format.__raw = ''function(entry, vim_item)
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
            treesitter = "󰙅",
          },
        }
        vim_item.kind = string.format("%s  %-20s | %s", icons.kind[vim_item.kind] or " ",
                                      vim_item.kind,
                                      icons.source[entry.source.name])
        return vim_item
      end'';
    };

    cmdline = let
      mapping = let
        arrows = prev: selectors (prev: "if cmp.get_selected_entry() ~= nil then") "fallback()" prev;
        tabs = prev: selectors (prev: "if cmp.visible() then") "cmp.complete()" prev;
      in makeMapping "c" {
        "<Up>" = arrows true;
        "<Down>" = arrows false;
        "<Tab>" = tabs false;
        "<S-Tab>" = tabs true;
      };
      buffer = {
        inherit mapping;
        sources = [ { name = "buffer"; } ];
        formatting.format = ''
        function(_, vim_item)
          vim_item.kind = ""
          return vim_item
        end
        '';
      };
    in {
      "/" = buffer;
      "?" = buffer;
      ":" = {
        inherit (buffer) mapping formatting;
        sources = [
          { name = "cmdline"; }
          { name = "async_path"; }
        ];
      };
    };
    filetype.gitcommit.sources = [
      { name = "git"; }
      { name = "buffer"; }
      { name = "async_path"; }
    ];
  };
}
