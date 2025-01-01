#!/bin/sh

SOURCE=$HOME/.config/yadm/hooks
DESTINATION=$HOME/.local/share/yadm/repo.git/hooks

for fname in $SOURCE/*; do
        HOOK=$(basename "$fname")
        if ! [ -L "$DESTINATION/$HOOK" ]; then
                ln -s "$SOURCE/$HOOK" "$DESTINATION/$HOOK"
                echo "symlink: $SOURCE/$HOOK -> $DESTINATION/$HOOK"
        fi
done
