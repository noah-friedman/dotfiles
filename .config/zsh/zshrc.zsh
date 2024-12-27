function zshrc {
        local config=${XDG_CONFIG_HOME:-$HOME/.config}

        # Local-only files that should be sourced before loading Zi (if any)
        if [ -d $config/local/zsh/source/before ]
        then
                for file in $config/local/zsh/source/before/**/*
                        . $file
        fi

        # Files that should be sourced before loading Zi
        for file in $config/zsh/source/before/**/*
                . $file

        # Load Zi
        typeset -Ag ZI
        typeset -gx ZI[HOME_DIR]="${HOME}/.local/share/zi"
        typeset -gx ZI[BIN_DIR]="$ZI[HOME_DIR]/bin"
        [ ! -d "$ZI[BIN_DIR]" ] && command mkdir -p "$ZI[BIN_DIR]"
        [ ! -d "$ZI[BIN_DIR]/.git" ] && \
                command git clone https://github.com/z-shell/zi.git "$ZI[BIN_DIR]"
        source "${ZI[BIN_DIR]}/zi.zsh"
        autoload -Uz _zi
        (( ${+_comps} )) && _comps[zi]=_zi

        # Files that should be sourced after loading Zi
        for file in $config/zsh/source/after/**/*
                . $file

        # Local-only files that should be sourced after loading Zi (if any)
        if [ -d $config/local/zsh/source/after ]
        then
                for file in $config/local/zsh/source/after/**/*
                        . $file
        fi
}
zshrc
unfunction zshrc
