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

# Array of bright colors to use randomly
COLORS=(57 99 141 147 159 183 198 205 212 219 226 105 177 51 87 201 123 45 190 196 220)

# Function to get a random color from our array
get_random_color() {
    echo ${COLORS[$RANDOM % ${#COLORS[@]}]}
}

# Generate fortune cowsay output with colorful cowsay
if command -v fortune > /dev/null && command -v cowsay > /dev/null; then
    cowfile=$(cowsay -l | tail -n +2 | tr ' ' '\n' | shuf -n 1)
    FORTUNE_TEXT=$(fortune)
    COWSAY_COLOR=$(get_random_color)
    FORTUNE_OUTPUT=$(gum style --foreground $COWSAY_COLOR "$(echo "$FORTUNE_TEXT" | cowsay -f "$cowfile")")
else
    FORTUNE_OUTPUT=$(gum style --foreground $(get_random_color) --bold "Install fortune and cowsay for daily quotes!")
fi

# Create a temporary file for the content
TEMP_FILE=$(mktemp)

# Random colors for each element
WELCOME_COLOR=$(get_random_color)
DATE_LABEL_COLOR=$(get_random_color)
DATE_VALUE_COLOR=$(get_random_color)
TIME_LABEL_COLOR=$(get_random_color)
TIME_VALUE_COLOR=$(get_random_color)
BORDER_COLOR=$(get_random_color)
USERNAME_COLOR=$(get_random_color)
DISTRO_COLOR=$(get_random_color)

# Write the content to the temporary file with random colors
cat > "$TEMP_FILE" << EOF
$(gum style --align center --foreground $WELCOME_COLOR --bold --underline "Welcome to $(gum style --foreground $DISTRO_COLOR "$DISTRO_NAME")'s Terminal $(gum style --foreground $USERNAME_COLOR "$USER")")

$(gum style --align center --foreground $DATE_LABEL_COLOR "Today is $(gum style --foreground $DATE_VALUE_COLOR --bold "$CURRENT_DATE")")
$(gum style --align center --foreground $TIME_LABEL_COLOR "The time is $(gum style --foreground $TIME_VALUE_COLOR --bold "$CURRENT_TIME")")

$FORTUNE_OUTPUT
EOF

# Output everything in a single border with random color
gum style --width $TERM_WIDTH --border double --margin "1" --padding "2 4" --border-foreground $BORDER_COLOR "$(cat "$TEMP_FILE")"

# Clean up
rm "$TEMP_FILE"

# Add some colorful decoration at the bottom
DECORATION=""
for i in {1..20}; do
    DECORATION+="$(gum style --foreground $(get_random_color) "◆ ")"
done

echo
gum style --align center "$DECORATION"

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