#!/bin/bash
set -xeuo pipefail

cd $(dirname $0)
dir=$(pwd)
virtme="$dir/virtme-rrn/virtme-run"

cd "$dir/linux"

echo hello
$virtme --help
