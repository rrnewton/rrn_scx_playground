#!/bin/bash
echo "Hello from Bash in the guest..."
set -xeuo pipefail

cat /sys/kernel/sched_ext/state
cat /sys/kernel/sched_ext/enable_seq

if [ -e /sys/kernel/sched_ext/root/ops ]; then
    cat /sys/kernel/sched_ext/root/ops
fi


RED='\033[0;31m'  # Red text
GREEN='\033[0;32m'  # Green text
BLUE='\033[0;94m'  # Bright Blue
RESET='\033[0m'   # Reset to default color

function redcolor() {
    set +x
    # Read input line by line and print in color
    while IFS= read -r line; do
        echo -e "${RED}${line}${RESET}"
    done
}

function greencolor() {
    set +x
    while IFS= read -r line; do
        echo -e "${GREEN}${line}${RESET}"
    done
}

function bluecolor() {
    set +x
    while IFS= read -r line; do
        echo -e "${BLUE}${line}${RESET}"
    done
}

function trial() {
    # tail -f $1 > >(nc -l -p 9977) &
    ./tools/sched_ext/build/bin/scx_qmap -P > >(greencolor) &
    test_pid=$!
    sleep 1
    cat /sys/kernel/debug/tracing/trace_pipe > >(redcolor) &
    cat_pid=$!

    ../schtest/target/debug/schtest --filter spread_out 2>&1 | bluecolor
    kill -SIGINT $test_pid
    kill $cat_pid
    echo "SCX invocation count: "$(cat /sys/kernel/sched_ext/enable_seq)
}

(whoami; cat /proc/self/cgroup; find /sys/fs/cgroup) | greencolor
trial;
trial;

echo "Done with script."
