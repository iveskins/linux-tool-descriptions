#!/bin/bash

# File to store tool descriptions
output_file=~/all_tools_descriptions3.txt

# Clear previous data in the file
> $output_file

{
    # Packages Currently Installed
    dpkg -l | awk 'NR>5 {print $2 " - " $3}'

    # Compiled from Source and Everything in PATH
    IFS=:
    for dir in $PATH; do
        for cmd in $dir/*; do
            if [ -x "$cmd" ] && [ ! -d "$cmd" ]; then
                description=$(whatis $(basename $cmd) 2>/dev/null)
                if [ $? -eq 0 ]; then
                    echo "$description"
                else
                    echo "$(basename $cmd) - No description available"
                fi
            fi
        done
    done
    unset IFS

    # Snap Tools
    snap list | awk 'NR>1 {print $1 " - " $2}'

    # Flatpak Tools
    flatpak list --app --columns=name,description

    # AppImages in likely locations
    for dir in ~/ /opt/ /usr/local/bin/; do
        find $dir -maxdepth 3 -name "*.AppImage" 2>/dev/null | while read appimage; do
            description=$($appimage --appimage-help 2>&1 | head -n 3 | tail -n 1)
            if [[ "$description" == *"--appimage-help"* ]]; then
                echo "$appimage - AppImage"
            else
                echo "$appimage - $description"
            fi
        done
    done

    # Extract paths to AppImages from .desktop files
    grep -r "Exec=" ~/.local/share/applications/ | grep ".AppImage" | awk -F "Exec=" '{print $2}' | awk '{print $1}'

} > $output_file

echo "Descriptions saved to $output_file"


