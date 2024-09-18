#!/bin/bash -e

set -x

install -v -m 644 files/PUP-run-once.service "${ROOTFS_DIR}/lib/systemd/system/"
install -v -m 755 files/PUP-run-once.sh "${ROOTFS_DIR}/usr/bin/"

on_chroot << EOF
systemctl enable PUP-run-once
EOF