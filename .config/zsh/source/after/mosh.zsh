function mosh {
        command mosh $1 -- screen -q ${@:2}
}
