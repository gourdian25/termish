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

# Current date and time in formal format - use system time
CURRENT_DATE=$(date +"%A, %B %d, %Y")
CURRENT_TIME=$(date +"%I:%M %p")

# Array of bright colors to use randomly
COLORS=(57 99 141 147 159 183 198 205 212 219 226 105 177 51 87 201 123 45 190 196 220)

# Function to get a random color from our array
get_random_color() {
    echo ${COLORS[$RANDOM % ${#COLORS[@]}]}
}

# Generate colors for each element
WELCOME_COLOR=$(get_random_color)
DATE_COLOR=$(get_random_color)
TIME_COLOR=$(get_random_color)
BORDER_COLOR=$(get_random_color)
USERNAME_COLOR=$(get_random_color)
DISTRO_COLOR=$(get_random_color)

# Generate fortune cowsay output with colorful cowsay
if command -v fortune > /dev/null && command -v cowsay > /dev/null; then
    cowfile=$(cowsay -l | tail -n +2 | tr ' ' '\n' | shuf -n 1)
    FORTUNE_OUTPUT=$(fortune | cowsay -f "$cowfile" | gum style --foreground $(get_random_color))
else
    FORTUNE_OUTPUT=$(gum style --foreground $(get_random_color) --bold "Install fortune and cowsay for daily quotes!")
fi

# Create a temporary file for the content
TEMP_FILE=$(mktemp)

# Create the welcome line WITHOUT nesting gum style commands
# Format each part separately
WELCOME_HEADER="Welcome to"
STYLED_DISTRO=$(gum style --foreground $DISTRO_COLOR "$DISTRO_NAME")
TERMINAL_TEXT="'s Terminal"
STYLED_USER=$(gum style --foreground $USERNAME_COLOR "$USER")

# Write the content to the temporary file
cat > "$TEMP_FILE" << EOF
$(gum style --align center "$WELCOME_HEADER $STYLED_DISTRO$TERMINAL_TEXT $STYLED_USER")

$(gum style --align center --foreground $DATE_COLOR "Today is $CURRENT_DATE")
$(gum style --align center --foreground $TIME_COLOR "The time is $CURRENT_TIME")

$FORTUNE_OUTPUT
EOF

# Output everything in a single border with random color
gum style --width $TERM_WIDTH --border double --margin "1" --padding "2 4" --border-foreground $BORDER_COLOR "$(cat "$TEMP_FILE")"

# Clean up
rm "$TEMP_FILE"

# Add some colorful decoration at the bottom with block characters
BLOCK_CHARS=("█" "▓" "▒" "░" "■" "□" "▪" "▫" "▬" "▭" "▮" "▯")
DECORATION=""
for ((i=0; i<TERM_WIDTH; i++)); do
    BLOCK_CHAR=${BLOCK_CHARS[$RANDOM % ${#BLOCK_CHARS[@]}]}
    DECORATION+="$(gum style --foreground $(get_random_color) "$BLOCK_CHAR")"
done

echo
echo "$DECORATION"

# Display a random motivational message in a different color box
MESSAGES=(
    "Have a productive day!"
    "Time to code something amazing!"
    "Remember to stay hydrated!"
    "Don't forget to stretch occasionally!"
    "You're going to accomplish great things today!"
    "Keep being awesome!"
    "Today is full of possibilities!"
)

RANDOM_MESSAGE=${MESSAGES[$RANDOM % ${#MESSAGES[@]}]}
MESSAGE_COLOR=$(get_random_color)
BOX_COLOR=$(get_random_color)

gum style --align center --width $TERM_WIDTH --margin "1" --padding "1 2" --border normal --border-foreground $BOX_COLOR "$(gum style --foreground $MESSAGE_COLOR --bold "$RANDOM_MESSAGE")"

# Add some colorful decoration at the bottom with block characters
DECORATION=""
for ((i=0; i<TERM_WIDTH; i++)); do
    BLOCK_CHAR=${BLOCK_CHARS[$RANDOM % ${#BLOCK_CHARS[@]}]}
    DECORATION+="$(gum style --foreground $(get_random_color) "$BLOCK_CHAR")"
done

echo
echo "$DECORATION"