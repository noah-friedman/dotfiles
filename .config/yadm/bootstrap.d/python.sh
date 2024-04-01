#!/bin/sh

. "$UTIL"

PYTHON_EXEC="python3"

if ! cmd_exists python3; then
        if cmd_exists python; then
                PYTHON_EXEC="python"
        elif cmd_exists python2; then
                PYTHON_EXEC="python2"
        elif cmd_exists py; then
                PYTHON_EXEC="py"
        else
                echo "Python not found, Skipping Python bootstrapping..."
                return
        fi
fi

if ! cmd_exists pipx; then
        $PYTHON_EXEC -m pip install --break-system-packages pipx
        pipx ensurepath
fi

if ! cmd_exists virtualenv; then
        pipx install virtualenv
fi
