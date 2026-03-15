#!/bin/sh
# CinemaIQ Premium - Official Installer
# =================================================

PLUGIN_DIR="/usr/lib/enigma2/python/Plugins/Extensions/CinemaIQ"
TMP_DIR="/tmp/cinemaiq_install"
REPO_URL="https://raw.githubusercontent.com/asdrere123-alt/CinemaIQ/main"

echo "🚀 Starting CinemaIQ Premium Installation..."

# 1. Clean old installation
echo "🧹 Removing old versions..."
rm -rf "$PLUGIN_DIR"
mkdir -p "$PLUGIN_DIR"

# 2. Download files
echo "📥 Downloading plugin files..."
wget --no-check-certificate "$REPO_URL/plugin.pyc" -O "$PLUGIN_DIR/plugin.pyc"
wget --no-check-certificate "$REPO_URL/__init__.py" -O "$PLUGIN_DIR/__init__.py"
wget --no-check-certificate "$REPO_URL/plugin.png" -O "$PLUGIN_DIR/plugin.png"

# 3. Handle Metadata
mkdir -p "$PLUGIN_DIR/meta"
wget --no-check-certificate "$REPO_URL/meta/plugin_cinemaiq.xml" -O "$PLUGIN_DIR/meta/plugin_cinemaiq.xml"

# 4. Deep Clean & Fresh Configuration
KEYS_FILE="/etc/cinemaiq_keys.conf"
DEBUG_LOG="/tmp/cinemaiq_debug.log"
TMP_CACHE="/tmp/cinemaiq/"

echo "🧹 Performing deep clean of old configurations and logs..."
rm -f "$KEYS_FILE"
rm -f "$DEBUG_LOG"
rm -rf "$TMP_CACHE"

echo "🔑 Creating fresh keys.conf template at $KEYS_FILE"
echo "# CinemaIQ API Keys Configuration" > "$KEYS_FILE"
echo "# Get your keys at: https://console.groq.com/ | https://www.themoviedb.org/settings/api" >> "$KEYS_FILE"
echo "GROQ_KEY=" >> "$KEYS_FILE"
echo "TMDB_KEY=" >> "$KEYS_FILE"
echo "OMDB_KEY=" >> "$KEYS_FILE"

chmod 755 "$PLUGIN_DIR/plugin.pyc"

echo "================================================="
echo "✅ CinemaIQ Installation Complete!"
echo "🔄 GUI will restart in 5 seconds..."
echo "================================================="
sleep 1; echo "4..."; sleep 1; echo "3..."; sleep 1; echo "2..."; sleep 1; echo "1..."; sleep 1;
killall -9 enigma2
