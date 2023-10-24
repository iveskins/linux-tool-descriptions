#!/bin/bash

# APT Tools
apt-cache search . | awk -F ' - ' '{printf "%-30s - %s\n", $1, $2}' >> ~/all_tools_descriptions.txt

# Compiled from Source and Everything in PATH
IFS=:
for dir in $PATH; do
    for cmd in $dir/*; do
        if [ -x "$cmd" ] && [ ! -d "$cmd" ]; then
            description=$(whatis $(basename $cmd) 2>/dev/null)
            if [ $? -eq 0 ]; then
                echo "$description" >> ~/all_tools_descriptions.txt
            else
                echo "$(basename $cmd) - No description available" >> ~/all_tools_descriptions.txt
            fi
        fi
    done
done
unset IFS

# Snap Tools
snap list | awk '{if(NR>1) print $1 " - " $2}' >> ~/all_tools_descriptions.txt

# Flatpak Tools
flatpak list --app --columns=name,description >> ~/all_tools_descriptions.txt

# AppImages (Replace with your directory if you store them in a specific location)
for file in $(find / -name "*.AppImage" 2>/dev/null); do
    echo "$file - AppImage" >> ~/all_tools_descriptions.txt
done

