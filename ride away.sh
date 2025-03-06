#!/bin/sh
echo -ne '\033c\033]0;road trip\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/ride away.x86_64" "$@"
