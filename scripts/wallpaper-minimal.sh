#!/bin/bash

# Minimal wallpaper script for hyprland-minimal
# Uses Pictures/wallpaper folder

WALLPAPER_DIR="$HOME/Pictures/wallpaper"

# Find all image files
IMAGES=()
while IFS= read -r -d '' file; do
    IMAGES+=("$file")
done < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.gif" \) -print0 2>/dev/null)

# Check if we found any images
if [ ${#IMAGES[@]} -eq 0 ]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Select random image
RANDOM_INDEX=$((RANDOM % ${#IMAGES[@]}))
SELECTED_IMAGE="${IMAGES[$RANDOM_INDEX]}"

# Set wallpaper with swww
if command -v swww >/dev/null 2>&1; then
    swww img "$SELECTED_IMAGE" --transition-type random --transition-duration 2
    echo "Wallpaper set to: $(basename "$SELECTED_IMAGE")"
    
    # -------------------------------------------------------------------
    # DYNAMIC COLOR EXTRACTION
    # -------------------------------------------------------------------
    # Extract the most vibrant/readable accent color from the image
    NEW_COLOR=$(python3 "$HOME/.config/hypr/scripts/get_accent.py" "$SELECTED_IMAGE")
    
    # Default to cyan if extraction fails
    if [ -z "$NEW_COLOR" ]; then NEW_COLOR="22D3EE"; fi

    # Update all conky configs with the new color
    # (Assuming color3 is the primary accent color across all configs)
    sed -i "s/color3 = '[A-Fa-f0-9]*'/color3 = '$NEW_COLOR'/g" "$HOME/.config/conky/modern_awesome_clock.conf"
    sed -i "s/color3 = '[A-Fa-f0-9]*'/color3 = '$NEW_COLOR'/g" "$HOME/.config/conky/vertical_modern_clock.conf"
    sed -i "s/color3 = '[A-Fa-f0-9]*'/color3 = '$NEW_COLOR'/g" "$HOME/.config/conky/aesthetic_glass_clock.conf"
    
    # -------------------------------------------------------------------
    # RANDOM CONKY HUD SELECTOR
    # -------------------------------------------------------------------
    # Kill existing custom conky instances
    pkill -f "conky -c /home/zius/.config/conky/"
    
    # Define your HUD configurations
    HUD_CONFIGS=(
        "$HOME/.config/conky/modern_awesome_clock.conf"
        "$HOME/.config/conky/vertical_modern_clock.conf"
        "$HOME/.config/conky/aesthetic_glass_clock.conf"
    )
    
    # Pick a random index
    HUD_INDEX=$((RANDOM % ${#HUD_CONFIGS[@]}))
    SELECTED_HUD="${HUD_CONFIGS[$HUD_INDEX]}"
    
    # Start the selected HUD in the background
    conky -c "$SELECTED_HUD" &
    # -------------------------------------------------------------------
    
else
    echo "Error: swww is not installed or not in PATH"
    exit 1
fi
