{ ... }: [''
  function _docker-custom {
    case $words[2] in
      disposable)
        export words=( "docker" "run" "''\${words[@]:2}" )
        ;;
      *sh)
        export words=( "docker" "exec" "-it" "''\${words[@]:2}" )
        ;;
    esac
    _docker
  }
  compdef _docker-custom docker
'']
