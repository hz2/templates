#!/usr/bin/env bash
# export every figures/ipe/*.ipe to an svg (for #image() in Typst) and a png
# preview (for visually reviewing the diagram).
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ipe_dir="$root/figures/ipe"
svg_dir="$root/figures/svg"
png_dir="$root/figures/png"

mkdir -p "$svg_dir" "$png_dir"

shopt -s nullglob
for src in "$ipe_dir"/*.ipe; do
    name="$(basename "$src" .ipe)"
    echo "exporting $name"
    iperender -svg "$src" "$svg_dir/$name.svg"
    iperender -png -resolution 150 "$src" "$png_dir/$name.png"
done
