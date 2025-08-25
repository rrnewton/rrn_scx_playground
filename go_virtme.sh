#!/bin/bash
# ASSUMES: Kernel is already built.
set -xeuo pipefail

cd $(dirname $0)
dir=$(pwd)
virtme="$dir/virtme-rrn/virtme-run"

make all

cd linux
PROG=../guest_script.sh
# PROG="../schtest/target/debug/schtest"
# PROG="whoami"

set +euo pipefail
echo "Running slightly patched Virtme..."
"$virtme" --kimg arch/x86/boot/bzImage --rw --pwd --cpus 50 --memory 120G --script-exec $PROG
# "$virtme" --kimg arch/x86/boot/bzImage --rw --pwd --cpus 3 --memory 2G --script-exec $PROG
echo "Virtme run complete: $?"
