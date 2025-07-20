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
YELLOW='\033[0;33m'  # Yellow text
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

function yellowcolor() {
    set +x
    while IFS= read -r line; do
        echo -e "${YELLOW}${line}${RESET}"
    done
}


# Takes the color as the first argument
function colorlines() {
    set +x
    # Read input line by line and print in color
    while IFS= read -r line; do
        echo -e "${1}${line}${RESET}"
    done
}

alias yellowcolor2="colorlines $YELLOW"

function trial() {
    ./tools/sched_ext/build/bin/scx_qmap -P > >(greencolor) &
    test_pid=$!
    sleep 1
    cat /sys/kernel/debug/tracing/trace_pipe > >(redcolor) &
    cat_pid=$!

    # Second scheduler fails of course, including non-zero exit code.''
    # ./tools/sched_ext/build/bin/scx_qmap || echo "PROCESS DIED, exit code $?"
    # ../scx/target/debug/scx_lavd || echo "PROCESS DIED, exit code $?"

    ../schtest/target/debug/schtest --filter spread_out 2>&1 | bluecolor
    kill -SIGINT $test_pid
    kill $cat_pid
    echo "SCX invocation count: "$(cat /sys/kernel/sched_ext/enable_seq)
}

(dmesg -W | yellowcolor) &
# (whoami; cat /proc/self/cgroup; find /sys/fs/cgroup) | greencolor
trial;
# trial;

echo "Done with script."
