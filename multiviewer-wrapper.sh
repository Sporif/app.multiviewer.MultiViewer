#!/bin/bash

set -euo pipefail

/app/bin/clean-gpucache || true

FLAGS=()

declare -i MULTIVIEWER_USE_WAYLAND="${MULTIVIEWER_USE_WAYLAND:-0}"

if [[ "${MULTIVIEWER_USE_WAYLAND}" -eq 1 && "${XDG_SESSION_TYPE}" == "wayland" ]]; then
    echo "MULTIVIEWER_USE_WAYLAND set, adding --ozone-platform=wayland to launch options"
    FLAGS+=(
        "--enable-features=WaylandWindowDecorations"
        "--ozone-platform=wayland"
    )
fi

export TMPDIR="${XDG_RUNTIME_DIR}/app/${FLATPAK_ID}"
exec zypak-wrapper "/app/multiviewer/MultiViewer for F1" "${FLAGS[@]}" "$@"
