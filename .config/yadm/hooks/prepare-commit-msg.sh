#!/bin/sh

FOUND_CHANGES=0
MESSAGE=""

resolve() {
        P=`realpath "$HOME/$GIT_PREFIX/$1"`
        P=`echo "$P" | sed "s#^$HOME/##"`
        echo "$P"
}

while read line; do
        if [ $FOUND_CHANGES -eq 0 ]; then
                if echo $line | grep -q "# Changes to be committed:"; then
                        FOUND_CHANGES=1
                fi
                continue
        elif [ $FOUND_CHANGES -eq 1 ] && echo $line | grep -q "^#$"; then
                break
        fi

        if [ "$MESSAGE" != "" ]; then
                MESSAGE="$MESSAGE\n\n"
        fi

        PROCESSING=`echo "$line" | sed 's/^#\t\(.*\)$/\1/'`
        ACTION=`echo "$PROCESSING" | sed 's/^\([^:]\{1,\}\): \{1,\}[^ ].*$/\1/'`
        FILEPATH=`echo "$PROCESSING" | sed 's/^[^:]\{1,\}: \{1,\}\([^ ].*\)$/\1/'`
        if [ "$ACTION" == "renamed" ]; then
                FP1=`echo "$FILEPATH" | sed 's/^\(.*\) -> .*$/\1/'`
                FP2=`echo "$FILEPATH" | sed 's/^.* -> \(.*\)$/\1/'`

                FNAME1=`echo "./$FP1" | sed 's#.*/\([^/]\{1,\}\)$#\1#'`
                FP1=`echo "./$FP1" | sed "s#^\\(.*\\)/$FNAME1\\\$#\\1#"`

                PROCESSING="$ACTION: `resolve "$FP1"`/$FNAME1 -> `resolve "$FP2"`"
        else
                PROCESSING="$ACTION: `resolve "$FILEPATH"`"
        fi

        MESSAGE="$MESSAGE$PROCESSING"
done < $1
echo "$MESSAGE$(cat $1)" > $1
