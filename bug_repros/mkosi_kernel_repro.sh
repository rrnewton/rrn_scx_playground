#!/bin/bash
uname -a
cat /etc/issue /etc/redhat-release
set -euo pipefail

# Optionally run this first:
# rm -rf $HOME/.cache/mkosi

if ! [ -d ./mkosi ]; then
    git clone https://github.com/systemd/mkosi
fi
(cd ./mkosi && git checkout 0d1143150835b21c1bfe64428df5f45b558280b1)
MKOSI_BIN_PATH="$PWD/mkosi/bin/"
export PATH="$PATH:$MKOSI_BIN_PATH"

echo;echo "Mkosi version, running from source:"
mkosi --version

if ! [ -d ./mkosi-kernel ]; then
    git clone https://github.com/DaanDeMeyer/mkosi-kernel.git
fi
cd ./mkosi-kernel
git checkout 7beb959e51354077ded4333d2c9951909ea46c75

# Permissions issues with some of the created VM files:
git clean -fxd || sudo git clean -fxd

# Check if `hostname` matches "*.facebook.com":
if hostname | grep -q '\.facebook\.com$'; then
    echo "Setting proxy!"
    # For devvm:
    export https_proxy="fwdproxy:8080"
fi

cat > ./mkosi.local.conf <<EOF
[Distribution]
Distribution=fedora
EOF

function maybe_sudo() {
    if [ "$(whoami)" == "root" ]; then
        $*
    else
        sudo $*
    fi
}


# As per the README:
maybe_sudo "$MKOSI_BIN_PATH/mkosi" --profile=kernel -f qemu
