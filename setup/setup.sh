#!/bin/bash

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

echo "\nAll operations completed successfully!"
