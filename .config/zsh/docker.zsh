function docker_ {
	case "$1" in
		disposable)
			command docker run --name disposable --rm -it ${@[@]:2}
			;;
		images-grep)
			command docker images -a --format 'table {{.Repository}}:{{.Tag}} {{.ID}}' | tail -n +2 | sed -nE "s/^$2.* ([A-z0-9]+)$/\\1/p"
			;;
		ps-grep)
			command docker ps -a --format 'table {{.Names}} {{.ID}}' | tail -n +2 | sed -nE "s/^$2.* ([A-z0-9]+)$/\\1/p"
			;;
		rmi-grep)
			command docker rmi $(docker images-grep $2)
			;;
		rm-grep)
			command docker rm $(docker ps-grep $2)
			;;
		*sh)
		       	if ! command docker ps --format '{{.Names}}' | grep -xq "$2"; then
                                if ! command docker start $2; then
                                        return 1
                                fi
                        fi
			command docker exec -it ${@[@]:2} $1
			;;
		*)
			command docker "$@"
			;;
	esac
}
function docker {
        if [ "$(uname)" = "Darwin" ]; then
                if ! command docker info &> /dev/null; then
                        open -a Docker
                        echo -n "Waiting for Docker to start ."

                        local slept=0
                        until [ $slept -eq 15 ] || command docker info &> /dev/null; do
                                sleep 1
                                ((slept++))
                                echo -n " ."
                        done
                        if [ $slept -eq 15 ]; then
                                echo " Docker failed to start"
                                return 1
                        fi
                fi
        fi

	docker_ $@
}

if [ -n `echo $ZSH_VERSION` ]; then
	function _docker-custom {
		case $words[2] in
			disposable)
				export words=( "docker" "run" "${words[@]:2}" )
				;;
			*sh)
				export words=( "docker" "exec" "-it" "${words[@]:2}" )
				;;
		esac
		if [ "${words[2]}" = "disposable" ]; then
			export words=( "docker" "run" ${words[@]:2} )
		fi
		_docker
	}
	compdef _docker-custom docker
fi
