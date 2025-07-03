#!/bin/bash
echo "Hello from Bash in the guest..."
set -xeuo pipefail

cat /sys/kernel/sched_ext/state
cat /sys/kernel/sched_ext/enable_seq

if [ -e /sys/kernel/sched_ext/root/ops ]; then
    cat /sys/kernel/sched_ext/root/ops
fi

function trial() {
    ./tools/sched_ext/build/bin/scx_simple &
    test_pid=$!

    sleep 3
    kill $test_pid
    sleep 1
    cat /sys/kernel/sched_ext/enable_seq
}

trial;
trial;

# ./schtest/target/debug/schtest --filter spread_out

echo "Done with script."
