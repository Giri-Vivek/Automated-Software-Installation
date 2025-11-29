#!/bin/bash

PACKAGE_FILE="packages.txt"
LOG_FILE="install_log.txt"

echo "Installation Log - $(date)" > "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

if [ ! -f "$PACKAGE_FILE" ]; then
    echo "Error: $PACKAGE_FILE not found!"
    exit 1
fi
echo "Updating package list..."
sudo apt update -y
while IFS= read -r package; do
    if [ -z "$package" ]; then
        continue
    fi
    echo "Installing: $package"
    sudo apt install -y "$package"

    if [ $? -eq 0 ]; then
        echo "$(date): SUCCESS installing $package" >> "$LOG_FILE"
    else
        echo "$(date): FAILED installing $package" >> "$LOG_FILE"
    fi
done < "$PACKAGE_FILE"

echo "Installation complete! Log saved to $LOG_FILE"

