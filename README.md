# Termish

**Termish** is a delightful command-line tool that enhances your terminal experience with a personalized welcome message. It provides a visually appealing greeting screen with the current date, time, and a randomly generated fortune quote displayed in a stylish cowsay format. Powered by [Gum CLI](https://github.com/charmbracelet/gum), Termish makes your terminal sessions more engaging and enjoyable.

---

## Features

- **Personalized Welcome Screen**:
  - Displays a custom greeting with your username and distribution name.
  - Shows the current date and time in a formal format.
  - Presents a random fortune quote in a cowsay format.

- **Elegant Interface**:
  - Powered by Gum CLI for beautiful text styling and formatting.
  - Centered text alignment with color-coded information.
  - Bordered display that adapts to your terminal width.

- **System Information**:
  - Automatically detects your distribution name (with WSL support).
  - Displays your username for a personalized experience.
  - Shows the current date and time in a readable format.

---

## Installation

You can install Termish directly using a single command. However, the installation method depends on your shell:

### For Bash or Zsh
Run the following command in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/gourdian25/termish/master/install.sh | sh
```

### For Fish Shell
Fish shell requires explicit use of `bash` to interpret the script. Run:

```fish
curl -fsSL https://raw.githubusercontent.com/gourdian25/termish/master/install.sh | bash
```

### Manual Installation
If the above methods don't work, you can manually download and install Termish:

1. Download the script:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/gourdian25/termish/master/install.sh -o install.sh
   ```

2. Make it executable:
   ```bash
   chmod +x install.sh
   ```

3. Run the script:
   ```bash
   ./install.sh
   ```

This script will:
1. Download the latest version of Termish.
2. Make it executable.
3. Place it in a directory included in your `$PATH` (e.g., `/usr/local/bin`).
4. Install the fortune and cowsay dependencies if they're not already installed.

---

## Usage

To start using Termish, simply run the following command:

```bash
termish
```

This will display a beautifully formatted welcome message in your terminal with:
- A personalized greeting with your username and distribution name
- The current date and time
- A random fortune quote displayed using cowsay (if installed)

---

## Dependencies

Before using Termish, ensure the following dependencies are installed:

1. **Gum CLI** (Required):
   - Powers the interactive and stylish interface.
   - Install on macOS:
     ```bash
     brew install gum
     ```
   - Install on Linux:
     ```bash
     sudo apt install gum
     ```
   - Alternatively, visit the [Gum CLI GitHub page](https://github.com/charmbracelet/gum) for installation instructions.

2. **Fortune** (Optional but recommended):
   - Provides random quotes for the welcome message.
   - Install on Ubuntu/Debian:
     ```bash
     sudo apt install fortune
     ```
   - Install on macOS:
     ```bash
     brew install fortune
     ```

3. **Cowsay** (Optional but recommended):
   - Displays the fortune quotes in a fun ASCII art format.
   - Install on Ubuntu/Debian:
     ```bash
     sudo apt install cowsay
     ```
   - Install on macOS:
     ```bash
     brew install cowsay
     ```

---

### Customization

Termish automatically adapts to your terminal width and uses your current username and distribution name. No additional configuration is required for basic usage.

---

## How It Works

Termish performs the following actions when run:

1. Checks if Gum CLI is installed and available.
2. Determines your terminal width to ensure proper formatting.
3. Gets your distribution name (with special handling for WSL environments).
4. Retrieves the current date and time.
5. Generates a random fortune quote using a randomly selected cowsay character (if installed).
6. Formats all information using Gum's styling capabilities.
7. Displays the formatted content in a bordered box.

---

## References

- **Gum CLI**: [https://github.com/charmbracelet/gum](https://github.com/charmbracelet/gum)
- **Cowsay**: [https://github.com/tnalpgge/rank-amateur-cowsay](https://github.com/tnalpgge/rank-amateur-cowsay)
- **Fortune**: [https://en.wikipedia.org/wiki/Fortune_(Unix)](https://en.wikipedia.org/wiki/Fortune_(Unix))

---

## Contributing

Contributions to Termish are welcome! If you'd like to contribute, please follow these steps:

1. Fork the repository: [https://github.com/gourdian25/termish](https://github.com/gourdian25/termish).
2. Create a new branch for your feature or bugfix.
3. Submit a pull request with a detailed description of your changes.

---

## License

Termish is open-source and licensed under the **MIT License**. See the [LICENSE](https://github.com/gourdian25/termish/blob/master/LICENSE) file for more details.

---

## Support

If you encounter any issues or have questions, please open an issue on the [GitHub repository](https://github.com/gourdian25/termish/issues).

---

## Author

Termish is developed and maintained by [gourdian25](https://github.com/gourdian25).

---

Thank you for using Termish! 🚀