autoload -Uz add-zsh-hook

function nvim_sync_recv { 
        local tmp=$(mktemp)
        nvim --server $NVIM --remote-expr "getcwd()" 1>/dev/null 2>$tmp
        cd `cat $tmp`
}


function nvim_sync_send {
        nvim --server $NVIM --remote-send "<CMD>cd $PWD<CR>"
}

if [ -z $NVIM ]; then
        add-zsh-hook preexec nvim_sync_recv
        add-zsh-hook chpwd nvim_sync_send
fi
