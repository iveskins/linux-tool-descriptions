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

# AppImages in likely locations
for dir in ~/ /opt/ /usr/local/bin/; do
    find $dir -name "*.AppImage" 2>/dev/null | while read file; do
        echo "$file - AppImage" >> ~/all_tools_descriptions.txt
    done
done

# Extract paths to AppImages from .desktop files
grep -r "Exec=" ~/.local/share/applications/ | grep ".AppImage" | awk -F "Exec=" '{print $2}' | awk '{print $1}' >> ~/all_tools_descriptions.txt


