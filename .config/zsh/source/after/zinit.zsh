zinit ice wait'!0' 
zinit load zsh-users/zsh-autosuggestions 
zinit ice wait'!0' 
zinit load zsh-users/zsh-syntax-highlighting
zinit ice wait'!0' 
zinit load speelbarrow/dracula-zsh

function cmd_exists {
        command -v $1 >/dev/null 2>&1
        return $?
}

if cmd_exists virtualenv; then
        zinit ice wait'!0' 
        zinit load MichaelAquilina/zsh-autoswitch-virtualenv
fi

unfunction cmd_exists
