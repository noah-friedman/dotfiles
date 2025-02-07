{ ... }: [''
docker() {
        case "$1" in
                disposable)
                        (shift 1; command docker run --rm -it --name disposable "$@")
                        ;;
                images-grep)
                        command docker images -a --format 'table {{.Repository}}:{{.Tag}} {{.ID}}' \
                                | tail -n +2 | sed -nE "s/^$2.* ([A-z0-9]+)$/\\1/p"
                        ;;
                ps-grep)
                        command docker ps -a --format 'table {{.Names}} {{.ID}}' | tail -n +2 \
                                | sed -nE "s/^$2.* ([A-z0-9]+)$/\\1/p"
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
                        command docker exec -it $(shift 1; printf "$@") $1
                        ;;
                *)
                        command docker "$@"
                        ;;
        esac
}
'']
