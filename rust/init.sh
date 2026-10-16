#!/usr/bin/env sh
# rename the template crate, then delete this script
# usage: sh init.sh <crate-name> [github-owner]
set -eu

name=${1:?usage: sh init.sh <crate-name> [github-owner]}
owner=${2:-hz2}

case $name in
  *[!a-z0-9_-]* | [!a-z]*)
    echo "crate name must be lowercase, start with a letter, and use only [a-z0-9_-]" >&2
    exit 1
    ;;
esac

ident=$(printf '%s' "$name" | tr - _)
cd "$(dirname "$0")"

# every text file except this script and flake.lock
files=$(grep -rlI --exclude-dir=.git --exclude-dir=target \
  --exclude=init.sh --exclude=flake.lock \
  -e rust-template -e rust_template -e 'github.com/hz2/' -e "owner == 'hz2'" . || true)

for f in $files; do
  sed -i.bak \
    -e "s/rust-template/$name/g" \
    -e "s/rust_template/$ident/g" \
    -e "s#github.com/hz2/#github.com/$owner/#g" \
    -e "s#gh/hz2/#gh/$owner/#g" \
    -e "s/repository_owner == 'hz2'/repository_owner == '$owner'/g" \
    "$f"
  rm -f "$f.bak"
done

rm -- "$0"
echo "renamed to $name; review the diff, then fill in description, keywords, and categories in Cargo.toml"
