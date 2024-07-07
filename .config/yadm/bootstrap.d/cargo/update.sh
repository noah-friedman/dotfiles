#!/bin/sh

. "$UTIL"

if cmd_exists nvim && cmd_exists cargo && ! cmd_exists cargo-install-update; then
        cargo install cargo-update
fi
