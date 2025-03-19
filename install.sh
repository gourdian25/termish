#!/bin/bash
# Termish Install Script
# This script installs Termish by downloading the latest version from GitHub,
# making it executable, and placing it in /usr/local/bin.
# It also ensures dependencies are installed and handles errors gracefully.

set -e  # Exit on any error

# Define the GitHub repository and script name
REPO="https://github.com/gourdian25/termish"
SCRIPT_NAME="termish"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="$HOME/.config/termish"
MESSAGES_FILE="messages.json"

# Colors for output
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# Function to log messages
log() {
    echo -e "${GREEN}[INFO]${RESET} $1"
}

# Function to log errors and exit
error() {
    echo -e "${RED}[ERROR]${RESET} $1"
    exit 1
}

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check for dependencies
log "Checking dependencies..."
if ! command_exists "curl"; then
    error "curl is required but not installed. Please install curl and try again."
fi

if ! command_exists "gum"; then
    log "${YELLOW}gum is not installed. Installing gum...${RESET}"
    if command_exists "brew"; then
        brew install gum
    elif command_exists "apt"; then
        sudo apt update && sudo apt install -y gum
    else
        error "gum is required but cannot be installed automatically. Please install it manually: https://github.com/charmbracelet/gum"
    fi
fi

# Download the script
log "Downloading Termish..."
curl -fsSL "${REPO}/raw/master/termish.sh" -o "/tmp/${SCRIPT_NAME}" || error "Failed to download Termish."

# Make the script executable
log "Making Termish executable..."
chmod +x "/tmp/${SCRIPT_NAME}" || error "Failed to make Termish executable."

# Move the script to /usr/local/bin
log "Installing Termish to ${INSTALL_DIR}..."
sudo mv "/tmp/${SCRIPT_NAME}" "${INSTALL_DIR}/${SCRIPT_NAME}" || error "Failed to move Termish to ${INSTALL_DIR}."

# Create the config directory if it doesn't exist
log "Setting up configuration..."
mkdir -p "$CONFIG_DIR" || error "Failed to create config directory: $CONFIG_DIR"

# Copy messages.json to the config directory
if [ -f "$MESSAGES_FILE" ]; then
    log "Copying messages.json to $CONFIG_DIR..."
    cp "$MESSAGES_FILE" "$CONFIG_DIR/" || error "Failed to copy messages.json to $CONFIG_DIR."
else
    log "${YELLOW}messages.json not found in the current directory. Skipping...${RESET}"
fi

# Verify installation
if command -v "${SCRIPT_NAME}" &> /dev/null; then
    echo -e "${GREEN}Termish installed successfully!${RESET}"
    echo -e "Run '${SCRIPT_NAME}' to start using the tool."
else
    error "Installation failed. Please check your permissions and try again."
fi