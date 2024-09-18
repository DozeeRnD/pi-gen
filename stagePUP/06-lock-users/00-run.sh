#!/bin/bash -e

set -x

on_chroot << EOF
    usermod -L root
    usermod -L ${FIRST_USER_NAME}
EOF