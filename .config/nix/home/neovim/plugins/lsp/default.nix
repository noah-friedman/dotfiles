{ config, lib, pkgs, ... }: let
in {
  cmp = let
    makeMapping = mode: maps: builtins.mapAttrs (n: v: "{ ${mode} = ${v} }") ({
      "<CR>" = "cmp.mapping.confirm({ select = ${if mode != "c" then "true" else "false"} })";
      "<S-BS>" = ''function()
        if cmp.visible_docs() then
          cmp.close_docs()
        else
          cmp.abort()
        end
      end'';
    } // maps);
    selectors = If: Else: prev: ''function(fallback)
      ${If prev}
        cmp.select_${if prev then "prev" else "next"}_item()
      else
        ${Else}
      end
    end'';
  in {
    enable = true;
    lazyLoad.settings.event = ["User FileOpened" "CmdlineEnter"];

    settings = {
      sources = [
        {
          name = "nvim_lsp";
          group_index = 1;
        }
        {
          name = "nvim_lsp_signature_help";
          group_index = 2;
        }
        {
          name = "treesitter";
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

  lsp = {
    enable = true;
    lazyLoad.settings.event = "User FileOpened";
    inlayHints = true;

    keymaps = {
      extra = lib.mapAttrsToList (n: v: {
        action = v;
        key = n;
        mode = ["n" "i" "v"];
      }) {
        "<F1>".__raw = ''function()

          local buffer = vim.api.nvim_get_current_buf()
          local client = vim.lsp.get_clients({ 
            name = "otter-ls[" .. buffer .. "]"
          })[1]
          if client ~= nil 
             and lang ~= nil 
             and lang ~= vim.api.nvim_buf_get_option(buffer, "filetype") 
          then
            client.request(
              vim.lsp.protocol.Methods.textDocument_hover,
              vim.lsp.util.make_position_params()
            )
          else
            vim.lsp.buf.hover()
          end
        end''; 
        # F2: smartRename -> home/neovim/plugins/treesitter.nix
        "<F3>".__raw = "vim.lsp.buf.code_action";
        "<F4>".__raw = ''function()
          require "telescope.builtin".lsp_definitions(require "telescope.themes".get_cursor {})
        end'';
        "<F5>".__raw = "vim.lsp.buf.implementation";
        "<F6>".__raw = "vim.diagnostic.open_float";
        # F10: noh -> home/neovim/keymaps/noh.nix
        "<F11>".__raw = "function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end";
        "<F12>".__raw = "function() vim.wo.spell = not vim.wo.spell end";
      };
    };

    onAttach = "require'otter'.activate(nil, true, false, nil)";

    servers = import ../../../../mkDir.nix {
      args = { inherit config lib pkgs; };
      inherit lib;
      path = ./.;
    };
  };
  
  lsp-format = {
    enable = true;
    lazyLoad.settings.event = "LspAttach";
  };
  otter = {
    enable = true;
    lazyLoad.settings.event = "LspAttach";
  };
  
  imports = [(pkgs.vimUtils.buildVimPlugin {
    name = "nvim-lsp-endhints";
    src = builtins.fetchTarball {
      url = "https://github.com/chrisgrieser/nvim-lsp-endhints/archive/main.tar.gz"; 
    };
  })];
  lz-n.plugins = [
    {
      __unkeyed-1 = "nvim-lsp-endhints";
      after.__raw = ''function()
        require'lsp-endhints'.setup()
      end'';
      event = "LspAttach";
    }
  ];
}
