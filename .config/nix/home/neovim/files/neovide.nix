{ pkgs, ... }: {
  "after/plugin/neovide.lua".text = ''
    if vim.g.neovide then
      vim.g.neovide_cursor_smooth_blink = true
      vim.o.winblend = 15
      vim.o.pumblend = 10
      ${if pkgs.stdenv.isDarwin
        then "vim.g.neovide_input_macos_option_key_is_meta = 'both'"
        else ""}
    end
  '';
}
