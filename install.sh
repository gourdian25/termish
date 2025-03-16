#!/bin/bash
# Sigil Install Script
# This script installs Sigil by downloading the latest version from GitHub,
# making it executable, and placing it in /usr/local/bin.

set -e  # Exit on any error

# Define the GitHub repository and script name
REPO="https://github.com/gourdian25/termish"
SCRIPT_NAME="termish"
INSTALL_DIR="/usr/local/bin"

# Download the script
echo -e "\033[1;32mDownloading Termish...\033[0m"
curl -fsSL "${REPO}/raw/master/termish.sh" -o "/tmp/${SCRIPT_NAME}"

# Make the script executable
echo -e "\033[1;32mMaking Termish executable...\033[0m"
chmod +x "/tmp/${SCRIPT_NAME}"

# Move the script to /usr/local/bin
echo -e "\033[1;32mInstalling Termish to ${INSTALL_DIR}...\033[0m"
sudo mv "/tmp/${SCRIPT_NAME}" "${INSTALL_DIR}/${SCRIPT_NAME}"

# Verify installation
if command -v "${SCRIPT_NAME}" &> /dev/null; then
    echo -e "\033[1;32mTermish installed successfully!\033[0m"
    echo -e "Run 'termish' to start using the tool."
else
    echo -e "\033[1;31mInstallation failed. Please check your permissions and try again.\033[0m"
    exit 1
fi