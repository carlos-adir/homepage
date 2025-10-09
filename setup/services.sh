#!/bin/bash

SYS_DIR="${HOME_DIR}/.config/systemd/user"

echo "Setting files after boot"
cp after-boot.service ${SYS_DIR}
systemctl --user enable after-boot.service