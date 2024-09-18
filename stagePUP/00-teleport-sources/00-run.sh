#!/bin/bash -e

set -x

install -v -m 644 files/teleport-archive-keyring.asc "${ROOTFS_DIR}/usr/share/keyrings/"
install -v -m 644 files/teleport.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"

on_chroot <<- \EOF
	apt-get update
EOF