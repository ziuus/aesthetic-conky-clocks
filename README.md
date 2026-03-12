# Obsidian HUD Suite 🌑

An ultra-premium collection of modern, stunning Conky clock widgets designed for Linux desktops (Hyprland/Wayland optimized). 

This suite features dynamic color extraction, high-end typography, and minimalist HUD designs that integrate seamlessly with your wallpaper.

## ✨ Features

- **3 Unique Designs:**
  - **Horizontal Aurora:** A wide, balanced dashboard for bottom corners.
  - **Vertical Pillar:** A narrow, monolithic column for a "Tech-Totem" look.
  - **Aesthetic Glass:** High-impact typography with a floating, zero-blur look.
- **Dynamic Color Sync:** Automatically extracts the most vibrant accent colors from your current wallpaper.
- **Nerd Font Integration:** Uses modern technical icons for CPU, RAM, and Battery.
- **Wayland Ready:** Optimized for Hyprland and Wayland environments.

## 🛠️ Dependencies

To get the full aesthetic experience, you need:

- **Conky:** The lightweight system monitor.
- **Fonts:**
  - [Inter Display](https://rsms.me/inter/)
  - [CaskaydiaCove Nerd Font](https://github.com/ryanoasis/nerd-fonts)
  - [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
- **Tools:**
  - `magick` (ImageMagick) for color extraction.
  - `python3` with `Pillow` (PIL) for smart accent color selection.
  - `swww` (for the random wallpaper integration).

## 🚀 Installation

1. **Clone the repo:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/obsidian-hud-suite.git
   cd obsidian-hud-suite
   ```

2. **Copy configurations:**
   ```bash
   mkdir -p ~/.config/conky ~/.config/hypr/scripts
   cp conky/*.conf ~/.config/conky/
   cp scripts/* ~/.config/hypr/scripts/
   chmod +x ~/.config/hypr/scripts/*.sh
   chmod +x ~/.config/hypr/scripts/*.py
   ```

3. **Usage:**
   Start any configuration directly:
   ```bash
   conky -c ~/.config/conky/aesthetic_glass_clock.conf
   ```

4. **Wallpaper Integration:**
   Update your Hyprland keybind to use the provided `wallpaper-minimal.sh` script for synchronized wallpaper and HUD randomization.

## 📜 License

MIT License. Feel free to modify and share!
