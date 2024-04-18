if ! [ -z $KITTY_PID ] && command -v kitty >/dev/null 2>&1; then
        alias ssh="kitty +kitten ssh"
fi
