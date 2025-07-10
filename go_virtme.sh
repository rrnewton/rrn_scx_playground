#!/bin/bash
# ASSUMES: Kernel is already built.
set -xeuo pipefail

cd $(dirname $0)
dir=$(pwd)
virtme="$dir/virtme-rrn/virtme-run"

# make hello.static
# PROG=../hello.static

cd "$dir/schtest"
cargo build

cd "$dir/linux"
make -j16 -C tools/sched_ext

PROG=../guest_script.sh
# PROG="../schtest/target/debug/schtest"
# PROG="whoami"

set +euo pipefail
echo "Running slightly patched Virtme..."
"$virtme" --kimg arch/x86/boot/bzImage --rw --pwd --cpus 3 --memory 1024M --script-exec $PROG
echo "Virtme run complete: $?"
