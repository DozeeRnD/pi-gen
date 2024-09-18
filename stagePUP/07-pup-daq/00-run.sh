#!/bin/bash -e

set -x

if [ ! -f files/pup_daq-*.whl ]; then
    echo "Please download the pup_daq wheel file from the PUP DAQ repository."
    echo "The file should be named pup_daq-<version>-py3-none-any.whl"
    echo "and should be placed in the files directory."
    exit 1
fi

PUP_WHL=$(ls files/pup_daq-*.whl)
PUP_WHL=$(basename ${PUP_WHL})

install -v -m 644 -o 1000 -g 1000 files/${PUP_WHL} "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/"

on_chroot << EOF
    su -c "uv tool install /home/${FIRST_USER_NAME}/${PUP_WHL} --python 3.12" ${FIRST_USER_NAME}
    rm /home/${FIRST_USER_NAME}/${PUP_WHL}
EOF