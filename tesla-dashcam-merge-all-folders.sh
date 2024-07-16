#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

for dir in */ ; do
    (
        cd "$dir" || exit
        "$SCRIPT_DIR/tesla-dashcam-merge.sh"
    )
done