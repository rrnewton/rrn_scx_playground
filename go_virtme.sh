#!/bin/bash
# ASSUMES: Kernel and ./hello.static are built already.

set -xeuo pipefail

cd $(dirname $0)
dir=$(pwd)
virtme="$dir/virtme-rrn/virtme-run"

cd "$dir/linux"

set +euo pipefail
echo "Running slightly patched Virtme..."
# cat | "$virtme" --kimg arch/x86/boot/bzImage --rw --pwd --memory 1024M --script-sh "echo HelloWorld"
"$virtme" --kimg arch/x86/boot/bzImage --rw --pwd --memory 1024M --script-exec ./hello.static

# Host File system is read/write, no? I guess that's just the guest root file system.
# "$virtme" --kimg arch/x86/boot/bzImage --rw --pwd --memory 1024M --script-sh "touch /home/newton/test_touch.txt"
echo "Virtme run complete: $?"
