#!/bin/bash -e

set -x

install -m 644 files/config.txt "${ROOTFS_DIR}/boot/firmware/"
