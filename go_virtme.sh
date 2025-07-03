#!/bin/bash
# ASSUMES: Kernel and ./hello.static are built already.

set -xeuo pipefail

cd $(dirname $0)
dir=$(pwd)
virtme="$dir/virtme-rrn/virtme-run"

cd "$dir/linux"

set +euo pipefail
echo "Running slightly patched Virtme..."
"$virtme" --kimg arch/x86/boot/bzImage --rw --pwd --memory 1024M --script-exec ../hello.static
echo "Virtme run complete: $?"
