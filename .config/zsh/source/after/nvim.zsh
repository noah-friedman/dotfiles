# Set EDITOR environment variable and `vim` command alias if Neovim found
if [ -x $(command -v nvim) ]; then
        export EDITOR='nvim'
        alias vim='nvim'

        if [[ -v NVIM ]]; then
                if ! [[ -v GHOSTTY_BIN_DIR ]]; then
                        # Keep the current directory in sync with Neovim's when in the Neovim terminal
                        function nvim_sync_recv {
                                local tmp=$(mktemp)
                                command nvim --server $NVIM --remote-expr "getcwd()" 1>/dev/null 2>$tmp
                                cd "$(cat $tmp)"
                        }
                        function nvim_sync_send {
                                command nvim --server $NVIM --remote-send "<CMD>cd $PWD<CR>"
                        }
                        autoload -Uz add-zsh-hook
                        add-zsh-hook preexec nvim_sync_recv
                        add-zsh-hook chpwd nvim_sync_send
                fi

                # Create an alias for 'nvim' that sends the file to the parent Neovim instance
                function nvim {
                        command nvim --server $NVIM --remote-send "<Cmd>lua vim.schedule_wrap(vim.cmd.e)('$(realpath $@)')<CR>"
                        [[ -v GHOSTTY_BIN_DIR ]] && command nvim --server $NVIM --remote-send "<Cmd>lua vim.schedule_wrap(vim.cmd.NeovideFocus)()<CR>"
                }
                function nvim-tab {
                        command nvim --server $NVIM --remote-send "<Cmd>tabnew<CR>"
                        command nvim --server $NVIM --remote-send "<Cmd>lua vim.schedule_wrap(vim.cmd.e)('$@')<CR>"
                }
                alias nvimt="nvim-tab"
                alias vim-tab="nvim-tab"
                alias vimt="nvim-tab"
        fi
fi
