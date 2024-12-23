alias zaa="eza -l --git --icons --header"
function z {
        local ignore=".git"

        if [ -e "$HOME/.ezaignore" ]; then
                ignore+="|$(cat $HOME/.ezaignore | grep -Ev -e '^#' | grep -Ev '^( |\t)*$' | tr '\n' '|' | sed -E 's/\/\|/|/g' | sed -E 's/(^|\|)\//\1/g' | sed -E 's/\|$//')"
        fi
        if [ -e "$HOME/.config/local/.ezaignore" ]; then
                ignore+="|$(cat $HOME/.config/local/.ezaignore | grep -Ev -e '^#' | grep -Ev '^( |\t)*$' | tr '\n' '|' | sed -E 's/\/\|/|/g' | sed -E 's/(^|\|)\//\1/g' | sed -E 's/\|$//')"
        fi

        local args="$@"
        if [ "$(dirname $PWD)" != "$(dirname $HOME)" ]; then
                args=" -a $@"
        fi

        zaa --git-ignore --ignore-glob="$ignore" $@
}
alias za='z -a'
alias zz='z --tree --level 5'
alias zza="za --tree --level 5"
