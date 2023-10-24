# AppImages in likely locations with descriptions
for dir in ~/ /opt/ /usr/local/bin/; do
    find $dir -maxdepth 3 -name "*.AppImage" 2>/dev/null | while read appimage; do
        description=$($appimage --appimage-help 2>&1 | head -n 3 | tail -n 1)  # Trying to get a brief description
        if [[ "$description" == *"--appimage-help"* ]]; then  # Check if the output was just the help flag
            echo "$appimage - AppImage"
        else
            echo "$appimage - $description"
        fi
    done
done


