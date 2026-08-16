#!/usr/bin/env bash
# export every figures/ipe/*.ipe to a vector pdf (for \includegraphics) and a
# png preview (for visually reviewing the diagram).
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ipe_dir="$root/figures/ipe"
pdf_dir="$root/figures/pdf"
png_dir="$root/figures/png"

mkdir -p "$pdf_dir" "$png_dir"

shopt -s nullglob
for src in "$ipe_dir"/*.ipe; do
    name="$(basename "$src" .ipe)"
    echo "exporting $name"
    ipetoipe -pdf "$src" "$pdf_dir/$name.pdf"
    iperender -png -resolution 150 "$src" "$png_dir/$name.png"
done
