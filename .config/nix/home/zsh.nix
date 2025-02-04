{ ... }: {
  programs.zsh = {
    enable = true;
    
    autosuggestion.enable = true;
    defaultKeymap = "emacs";

    envExtra = ''
      if [ -d "$HOME/.config/zsh/env" ]; then
        for F in $HOME/.config/zsh/env/*; do
          . $F
        done
      fi
    '';

    history = {
      share = true;
    };

    syntaxHighlighting = {
      enable = true;
    };
  };
}
