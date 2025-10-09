#!/bin/bash

# Set HOME_DIR to the home directory
HOME_DIR=~/

# Create derived directories
GIT_DIR="${HOME_DIR}/git"
WORK_DIR="${GIT_DIR}/gethomepage"
SYS_DIR="${HOME_DIR}/.config/systemd/user"

# Repository settings
GIT_REPO="https://github.com/gethomepage/homepage.git"
BRANCH="main"

# Root operations
echo "\nStarting root operations..."
read -p "Enter sudo password for system updates: " -s password
echo ""

# Update package lists
if ! echo "$password" | sudo -S apt-get update; then
    echo "Failed to update package lists!"
    exit 1
fi

# Upgrade system
if ! echo "$password" | sudo -S apt-get upgrade -y; then
    echo "Failed to upgrade system!"
    exit 1
fi

# Install packages
for pkg in git npm; do
    if ! echo "$password" | sudo -S apt-get install -y "$pkg"; then
        echo "Failed to install $pkg!"
        exit 1
    fi
done

# Install global npm package
if ! echo "$password" | sudo -S npm install -g pnpm; then
    echo "Failed to install pnpm globally!"
    exit 1
fi

echo "Setting files after boot"
cp after-boot.service ${SYS_DIR}
systemctl --user enable after-boot.service
chmod +x after-boot.sh

# This should be run only once, when the OS boots at first time |\
echo "Branch: ${BRANCH}"
echo "Git repo: ${GIT_REPO}"
echo "Destiny: ${WORK_DIR}"
git clone -b ${BRANCH} --depth 1 --single-branch ${GIT_REPO} ${WORK_DIR}
cd ${WORK_DIR} && pnpm install --max-old-space-size=512

echo "\nAll operations completed successfully!"
