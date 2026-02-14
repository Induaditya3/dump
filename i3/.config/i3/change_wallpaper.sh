#!/bin/bash
# Script for changing the wallpaper randomly
# This script is intended to be run as "exec --no-startup-id ~/.config/i3/change_wallpaper.sh" from i3 config file

set -e  # Exit on error

# Configuration
WALLS_DIR="$HOME/.local/share/wallpapers/walls"
WALLS_REPO="https://github.com/dharmx/walls.git"
CACHE_FILE="$HOME/.cache/current_wallpaper"

# Create cache directory if it doesn't exist
mkdir -p "$(dirname "$CACHE_FILE")"

# Check if repository is cloned, if not clone it
if [ ! -d "$WALLS_DIR" ]; then
    echo "Wallpapers repository not found. Cloning..."
    mkdir -p "$(dirname "$WALLS_DIR")"
    git clone "$WALLS_REPO" "$WALLS_DIR" || {
        echo "Error: Failed to clone wallpapers repository"
        exit 1
    }
fi

# Find all image files in subdirectories (excluding hidden files and git directory)
mapfile -t wallpapers < <(find "$WALLS_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) ! -path "*/.git/*" 2>/dev/null)

# Check if any wallpapers were found
if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "Error: No wallpapers found in $WALLS_DIR"
    exit 1
fi

# Select a random wallpaper
random_wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

# Check if feh is installed
if ! command -v feh &> /dev/null; then
    echo "Error: feh is not installed. Install it with: sudo pacman -S feh"
    exit 1
fi

# Set the wallpaper
feh --no-fehbg --bg-scale "$random_wallpaper" && {
    echo "Wallpaper changed to: $random_wallpaper"
    # Save current wallpaper to cache for reference
    echo "$random_wallpaper" > "$CACHE_FILE"
} || {
    echo "Error: Failed to set wallpaper"
    exit 1
}