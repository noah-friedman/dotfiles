{ lib, pkgs, ... }: {
  telescope = {
    enable = true;
    lazyLoad.settings = {
      cmd = "Telescope";
      keys = ["<A-v>"];
    };

    extensions = {
      file-browser = {
        enable = true;
        settings = {
          hijack_netrw = true;
          hidden = {
            file_browser = true;
            folder_browser = true;
          };
        };
      };
      undo.enable = true;
    };

    keymaps = let
      leader = "<A-v>";
    in lib.mapAttrs' (n: v: {
      name = "${leader}${n}";
      value = {
        action = v;
        mode = ["n" "i" "v" "c" "t"];
      };
    }) {
      "" = "";
      a = "autocommands";
      b = "file_browser";
      B = "file_browser path=%:p:h";
      d = "diagnostics bufnr=0";
      D = "diagnostics";
      f = "find_files";
      F = "find_files cwd=%:p:h";
      h = "help_tags";
      H = "highlights";
      g = "builtin default_text=git";
      k = "keymaps";
      n = "notify";
      o = "oldfiles";
      p = "projects";
      r = "live_grep";
      s = "symbols";
      u = "undo";
      v = "vim_options";
      "<Enter>" = "resume";
    };
  };
  imports = [pkgs.vimPlugins.telescope-symbols-nvim];
}
