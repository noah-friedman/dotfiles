function zshrc {
        local config=${XDG_CONFIG_HOME:-$HOME/.config}

        # Local-only files that should be sourced before loading zinit (if any)
        if [ -d $config/local/zsh/source/before ]
        then
                for file in $config/local/zsh/source/before/**/*
                        . $file
        fi

        # Files that should be sourced before loading zinit
        for file in $config/zsh/source/before/**/*
                . $file

        # Load zinit
        ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
        [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
        if [ ! -d $ZINIT_HOME/.git ]; then
                git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
        fi
        source "${ZINIT_HOME}/zinit.zsh"

        # Initialize completions
        autoload -Uz compinit
        compinit

        # Files that should be sourced after loading zinit
        for file in $config/zsh/source/after/**/*
                . $file

        # Local-only files that should be sourced after loading zinit (if any)
        if [ -d $config/local/zsh/source/after ]
        then
                for file in $config/local/zsh/source/after/**/*
                        . $file
        fi
}
zshrc
unfunction zshrc
