#!/bin/bash
echo "Hello from Bash in the guest..."
set -xeuo pipefail

cat /sys/kernel/sched_ext/state

if [ -e /sys/kernel/sched_ext/root/ops ]; then
    cat /sys/kernel/sched_ext/root/ops
fi

echo "Done with script."
