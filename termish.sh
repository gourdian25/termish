#!/bin/bash

# Check if Gum CLI is installed (required for the interactive interface)
if ! command -v gum &> /dev/null; then
    echo "Error: Gum CLI is not installed. Please install it first."
    echo "Visit: https://github.com/charmbracelet/gum"
    exit 1
fi

# Get terminal width (slightly reduced to prevent wrapping)
TERM_WIDTH=$(( $(tput cols) - 4 ))

# Get distro name with fallback
DISTRO_NAME=${WSL_DISTRO_NAME:-$(hostname)}

# Current date and time in formal format
CURRENT_DATE=$(date +"%A, %B %d, %Y")
CURRENT_TIME=$(date +"%I:%M %p")

# Generate fortune cowsay output if available
if command -v fortune > /dev/null && command -v cowsay > /dev/null; then
    cowfile=$(cowsay -l | tail -n +2 | tr ' ' '\n' | shuf -n 1)
    FORTUNE_OUTPUT=$(fortune | cowsay -f "$cowfile")
else
    FORTUNE_OUTPUT="Install fortune and cowsay for daily quotes!"
fi

# Create a temporary file for the content
TEMP_FILE=$(mktemp)

# Write the content to the temporary file
cat > "$TEMP_FILE" << EOF
$(gum style --align center --foreground 212 --bold --underline "Welcome to $DISTRO_NAME's Terminal $USER")

$(gum style --align center --foreground 99 "Today is $(gum style --foreground 219 "$CURRENT_DATE")")
$(gum style --align center --foreground 99 "The time is $(gum style --foreground 219 "$CURRENT_TIME")")

$(gum style --foreground 57 --italic "$FORTUNE_OUTPUT")
EOF

# Output everything in a single border that spans the entire screen
gum style --width $TERM_WIDTH --border double --margin "1" --padding "2 4" --border-foreground 99 "$(cat "$TEMP_FILE")"

# Clean up
rm "$TEMP_FILE"