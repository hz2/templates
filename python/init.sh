#!/usr/bin/env sh
# rename the template project, then delete this script
# usage: sh init.sh <project-name>
set -eu

name=${1:?usage: sh init.sh <project-name>}

case $name in
  *[!a-z0-9_-]* | [!a-z]*)
    echo "project name must be lowercase, start with a letter, and use only [a-z0-9_-]" >&2
    exit 1
    ;;
esac

ident=$(printf '%s' "$name" | tr - _)
cd "$(dirname "$0")"

files=$(grep -rlI --exclude-dir=.git --exclude=init.sh --exclude=flake.lock \
  -e python-template -e python_template . || true)

for f in $files; do
  sed -i.bak \
    -e "s/python-template/$name/g" \
    -e "s/python_template/$ident/g" \
    "$f"
  rm -f "$f.bak"
done

mv src/python_template "src/$ident"
rm -- "$0"
echo "renamed to $name"
