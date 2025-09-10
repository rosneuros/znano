#!/usr/bin/env bash

cd $ZNANO
if [ "$(date -u '+%H')" = "00" ] && [ "$(date -u '+%M')" = "00" ]; then
    git pull --rebase
    cp "$ZNANO/data/sub.txt" "$ZNANO/data/share/log/sub$(date -u '+%Y%m%d').txt"
    echo "" > "$ZNANO/data/sub.txt"
    hash=$(ipfs add -r --nocopy -Q "$ZNANO/data/share/log")
    ipfspub $hash
fi
if [ "$(date -u '+%M')" = "00" ] || [ "$(date -u '+%M')" = "30" ]; then
    for dir in apps/*/; do
      if [ -f "$dir/min30.sh" ]; then
        bash "$dir/min30.sh"
      fi
    done
    ipfspub 'Ok!'
fi
