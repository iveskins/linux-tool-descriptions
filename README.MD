
# Linux Tool Descriptions

A simple script to generate a list of descriptions for various tools, packages, and AppImages installed on a Linux system.

## Features
- Lists descriptions of installed packages.
- Lists executables found in `PATH` directories with descriptions.
- Lists installed Snap packages.
- Lists installed Flatpak applications.
- Attempts to extract descriptions from AppImages in common locations.
- Extracts paths to AppImages from `.desktop` files.

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/your_username/linux-tool-descriptions.git
   cd linux-tool-descriptions
   ```

2. Run the script:
   ```bash
   bash generate_descriptions.sh
   ```

3. Use `fzf` or any text editor to search through the generated `all_tools_descriptions.txt` file.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

