#!/usr/bin/env bash
#
# Generate the 5 web icons used by the PWA from the app icon.
#
# Web icons produced (in web/):
#   favicon.png           32x32    (opaque, favicon)
#   icons/Icon-192.png    192x192  (opaque, "any")
#   icons/Icon-512.png    512x512  (opaque, "any")
#   icons/Icon-maskable-192.png   192x192  (opaque + padding, "maskable")
#   icons/Icon-maskable-512.png   512x512  (opaque + padding, "maskable")
#
# Uses ImageMagick (`magick`).
#
# Maskable icons need extra padding so the artwork stays inside the safe zone
# (a circle whose diameter is 80 % of the canvas). We therefore scale the logo
# to SAFE_ZONE % of the icon size and center it on an opaque background.
#
# Usage:
#   ./tools/generate_web_icons.sh
# or:
#   SOURCE=assets/app-icon.svg SAFE_ZONE=80 ./tools/generate_web_icons.sh
set -euo pipefail

# Paths (relative to the repository root).
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WEB_DIR="$ROOT/web"
ICON_DIR="$WEB_DIR/icons"

# Source icon: prefer the high-resolution PNG, fall back to the SVG.
# Override with: SOURCE=path/to/icon
SOURCE="${SOURCE:-}"
if [[ -z "$SOURCE" ]]; then
    if [[ -f "$ROOT/assets/app-icon.png" ]]; then
        SOURCE="$ROOT/assets/app-icon.png"
    elif [[ -f "$ROOT/assets/app-icon.svg" ]]; then
        SOURCE="$ROOT/assets/app-icon.svg"
    else
        echo "error: no source icon found (assets/app-icon.png or assets/app-icon.svg)" >&2
        exit 1
    fi
fi
if [[ ! -f "$SOURCE" ]]; then
    echo "error: source icon not found: $SOURCE" >&2
    exit 1
fi

# Maskable safe-zone: the logo occupies SAFE_ZONE % of the icon (default 80 %).
SAFE_ZONE="${SAFE_ZONE:-80}"

# Opaque background used for the maskable icons (transparent backgrounds are
# not allowed in maskable icons). Override with: MASKABLE_BG=#hexcolor
MASKABLE_BG="${MASKABLE_BG:-#ffffff}"

# Opaque background used for the "any" icons and the favicon so they render
# consistently and don't pick up the page background. Override with:
# ANY_BG=#hexcolor
ANY_BG="${ANY_BG:-#ffffff}"

# Sizes: favicon + the 4 manifest icons.
FAVICON_SIZE="${FAVICON_SIZE:-32}"

mkdir -p "$ICON_DIR"

# Strip all metadata and timestamp chunks so the output is deterministic and
# the files don't change on every run (ImageMagick otherwise embeds
# date:create / date:modify and a tIME chunk in the PNG).
STRIP_ARGS=( -strip -define png:exclude-chunks=date,time )

# Render an "any" icon of the given size on an opaque background.
render_any() {
    local size="$1" out="$2" background="$3"
    magick "$SOURCE" \
        -resize "${size}x${size}^" \
        -background "$background" \
        -gravity center \
        -extent "${size}x${size}" \
        "${STRIP_ARGS[@]}" \
        "$out"
}

# Render an opaque maskable icon of the given size, with the logo scaled
# down to the safe zone and centered on an opaque background (padding).
render_maskable() {
    local size="$1" out="$2"
    local inner=$(( size * SAFE_ZONE / 100 ))
    magick -size "${size}x${size}" "xc:$MASKABLE_BG" \
        \( "$SOURCE" -resize "${inner}x${inner}^" \) \
        -gravity center \
        -composite \
        "${STRIP_ARGS[@]}" \
        "$out"
}

render_any "$FAVICON_SIZE" "$WEB_DIR/favicon.png" "$ANY_BG"
render_any 192 "$ICON_DIR/Icon-192.png" "$ANY_BG"
render_any 512 "$ICON_DIR/Icon-512.png" "$ANY_BG"
render_maskable 192 "$ICON_DIR/Icon-maskable-192.png"
render_maskable 512 "$ICON_DIR/Icon-maskable-512.png"

echo "Web icons generated from: $SOURCE"
echo "  web/favicon.png                        ${FAVICON_SIZE}x${FAVICON_SIZE} (bg ${ANY_BG})"
echo "  web/icons/Icon-192.png                 192x192 (bg ${ANY_BG})"
echo "  web/icons/Icon-512.png                 512x512 (bg ${ANY_BG})"
echo "  web/icons/Icon-maskable-192.png        192x192 (safe zone ${SAFE_ZONE}%, bg ${MASKABLE_BG})"
echo "  web/icons/Icon-maskable-512.png        512x512 (safe zone ${SAFE_ZONE}%, bg ${MASKABLE_BG})"
