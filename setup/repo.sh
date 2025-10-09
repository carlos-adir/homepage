#!/bin/bash

# Set HOME_DIR to the home directory
HOME_DIR=~/

# Create derived directories
GIT_DIR="${HOME_DIR}/git"
WORK_DIR="${GIT_DIR}/gethomepage"

# Repository settings
GIT_REPO="https://github.com/gethomepage/homepage.git"
BRANCH="main"

# This should be run only once, when the OS boots at first time |\
echo "Branch: ${BRANCH}"
echo "Git repo: ${GIT_REPO}"
echo "Destiny: ${WORK_DIR}"
git clone -b ${BRANCH} --depth 1 --single-branch ${GIT_REPO} ${WORK_DIR}
cd ${WORK_DIR} && pnpm install --max-old-space-size=512