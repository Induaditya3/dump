#!/bin/bash

# Script for changing the wallpaper randomly
# This script is intended to be run as "~/dump/i3/.config/i3/change_wallpaper.sh" from i3 config file
# it accepts additional option of `-d` for deleting current wallpaper and pushing to my github, and setting a new one
set -e  # Exit on error

# Configuration
WALLS_DIR="$HOME/.local/share/wallpapers/walls"
WALLS_REPO="git@github.com-personal:textCritique/walls.git"
CACHE_FILE="$HOME/.cache/current_wallpaper"
DELETE_MODE=false

# Parse command-line arguments
while getopts "d" opt; do
    case $opt in
        d)
            DELETE_MODE=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

# Create cache directory if it doesn't exist
mkdir -p "$(dirname "$CACHE_FILE")"

# Check if repository is cloned, if not clone it
if [ ! -d "$WALLS_DIR" ]; then
    notify-send -t 3000 "Wallpaper Changer" "Wallpapers repository not found. Cloning..."
    mkdir -p "$(dirname "$WALLS_DIR")"
    git clone "$WALLS_REPO" "$WALLS_DIR" || {
        notify-send -t 3000 -u critical "Wallpaper Changer" "Error: Failed to clone wallpapers repository"
        exit 1
    }
fi

# Handle delete mode
if [ "$DELETE_MODE" = true ]; then
    if [ -f "$CACHE_FILE" ]; then
        current_wallpaper=$(cat "$CACHE_FILE")
        if [ -f "$current_wallpaper" ]; then
            wallpaper_name=$(basename "$current_wallpaper")
            notify-send -t 3000 "Wallpaper Changer" "Deleting wallpaper: $wallpaper_name"
            
            # Delete the wallpaper
            rm "$current_wallpaper"
            
            # Git operations
            cd "$WALLS_DIR"
            git add .
            git commit -m "remove: didn't not like $wallpaper_name, so deleted"
            git push || {
                notify-send -t 3000 -u critical "Wallpaper Changer" "Error: Failed to push to git"
            }
            
            notify-send -t 3000 "Wallpaper Changer" "Wallpaper deleted and changes pushed to git"
        else
            notify-send -t 3000 "Wallpaper Changer" "Warning: Current wallpaper file not found"
        fi
    else
        notify-send -t 3000 "Wallpaper Changer" "Warning: No current wallpaper cached"
    fi
fi

# Find all image files in subdirectories (fd automatically ignores .git and hidden files)
mapfile -t wallpapers < <(fd -e jpg -e jpeg -e png -e webp -t f . "$WALLS_DIR")

# Check if any wallpapers were found
if [ ${#wallpapers[@]} -eq 0 ]; then
    notify-send -t 3000 -u critical "Wallpaper Changer" "Error: No wallpapers found in $WALLS_DIR"
    exit 1
fi

# Select a random wallpaper
random_wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

# Check if feh is installed
if ! command -v feh &> /dev/null; then
    notify-send -t 3000 -u critical "Wallpaper Changer" "Error: feh is not installed. Install it with: sudo pacman -S feh"
    exit 1
fi

# Set the wallpaper
feh --no-fehbg --bg-scale "$random_wallpaper" && {
    notify-send -t 3000 "Wallpaper Changer" "Wallpaper changed successfully"
    # Save current wallpaper to cache for reference
    echo "$random_wallpaper" > "$CACHE_FILE"
} || {
    notify-send -t 3000 -u critical "Wallpaper Changer" "Error: Failed to set wallpaper"
    exit 1
}
