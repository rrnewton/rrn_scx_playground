#!/bin/bash
uname -a
cat /etc/issue /etc/redhat-release
set -euo pipefail

if ! [ -d ./mkosi ]; then
    git clone https://github.com/systemd/mkosi
fi
(cd ./mkosi && git checkout 0d1143150835b21c1bfe64428df5f45b558280b1)
export PATH="$PATH:$PWD/mkosi/bin/"

echo;echo "Mkosi version, running from source:"
mkosi --version

if ! [ -d ./mkosi-kernel ]; then
    git clone https://github.com/DaanDeMeyer/mkosi-kernel.git
fi
cd ./mkosi-kernel
git checkout 7beb959e51354077ded4333d2c9951909ea46c75
git clean -fd

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

# As per the README:
mkosi -f qemu
