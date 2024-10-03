#!/bin/bash

set -e

dir=~/.var/app/app.multiviewer.MultiViewer/config/"MultiViewer for F1"/GPUCache
libdrm_status="$(stat --format=%Z /usr/lib/*/libdrm.so.?)"

if [ -d "$dir" ]; then
    find "$dir" -maxdepth 1 -mindepth 1 -print0 |
    while IFS= read -r -d '' f; do
        if [ "$libdrm_status" -gt "$(stat --format=%Y "$f")" ];then
            echo "clean-gpucache: deleting stale gpu cache file: $f"
            rm "$f"
        fi
    done
fi
