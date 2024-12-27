zi load speelbarrow/dracula-zsh
zi wait'!0' for \
        zsh-users/zsh-syntax-highlighting
zi wait'!0' for \
        OMZ::plugins/git/git.plugin.zsh
zi wait lucid for \
        zsh-users/zsh-autosuggestions
zi wait lucid atload"zicompinit; zicdreplay" blockf for \
        zsh-users/zsh-completions

function cmd_exists {
        command -v $1 >/dev/null 2>&1
        return $?
}

if cmd_exists virtualenv; then
        zinit ice wait'!0'
        zinit load MichaelAquilina/zsh-autoswitch-virtualenv
fi

unfunction cmd_exists
