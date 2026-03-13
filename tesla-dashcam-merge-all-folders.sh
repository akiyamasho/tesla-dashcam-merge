#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
MERGE_GRID=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --merge-grid) MERGE_GRID=true;;
        *) echo "Unknown parameter passed: $1"; exit 1;;
    esac
    shift
done

for dir in */ ; do
    (
        cd "$dir" || exit
        if $MERGE_GRID; then
            "$SCRIPT_DIR/tesla-dashcam-merge.sh" --merge-grid
        else
            "$SCRIPT_DIR/tesla-dashcam-merge.sh"
        fi
    )
done
