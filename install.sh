#!/usr/bin/env bash
# Installs the Awake Timer Cinnamon applet (awake@enisn) for the current user.
set -e

SRC="$(cd "$(dirname "$0")" && pwd)/awake@enisn"
DEST="$HOME/.local/share/cinnamon/applets/awake@enisn"

if [ ! -f "$SRC/applet.js" ] || [ ! -f "$SRC/metadata.json" ]; then
    echo "Error: awake@enisn applet files not found next to install.sh" >&2
    exit 1
fi

mkdir -p "$HOME/.local/share/cinnamon/applets"
rm -rf "$DEST"
cp -r "$SRC" "$DEST"

echo "Installed Awake Timer to $DEST"
echo
echo "Next: open System Settings -> Applets, find 'Awake Timer', and add it to a panel."
