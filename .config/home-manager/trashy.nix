{ pkgs }: {
  packages = if pkgs.stdenv.isLinux
             then with pkgs; [ trashy ]
             else [];

  aliases = {
    rm = ''echo "Are you sure you didn't mean \`trash\`?"'';
  };
}
