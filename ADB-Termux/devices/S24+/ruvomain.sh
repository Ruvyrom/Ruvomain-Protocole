#!/usr/bin/env bash
# Ruvomain ADB-Termux Debloater
# Version 2.0.0
# Created by Ruvyrom - 16 years of Android modding, 0 patience for bloat.
# This script is for personal use, use at your own risk.
set -euo pipefail

show_logo() {
cat <<- "EOF"
    ____                                    _     
   / __ \__  ___   ______  ____ ___  ____ _(_)___ 
  / /_/ / / / / | / / __ \/ __ `__ \/ __ `/ / __ \
 / _, _/ /_/ /| |/ / /_/ / / / / / / /_/ / / / / /
/_/ |_|\__,_/ |___/\____/_/ /_/ /_/\__,_/_/_/ /_/ 
   / __ \_________  / /_____  _________  / /__    
  / /_/ / ___/ __ \/ __/ __ \/ ___/ __ \/ / _ \   
 / ____/ /  / /_/ / /_/ /_/ / /__/ /_/ / /  __/   
/_/   /_/   \____/\__/\____/\___/\____/_/\___/    
                                                  
EOF
}                                                  

# --- Model verification ---
REQUIRED_MODEL="SM-S926B"
# Detect model locally or via ADB
CURRENT_MODEL=$(getprop ro.product.model 2>/dev/null || adb shell getprop ro.product.model)

if [ "$CURRENT_MODEL" != "$REQUIRED_MODEL" ]; then
echo "⚠️ WARNING: Detected device model: $CURRENT_MODEL"
echo "This script is specifically optimized for the $REQUIRED_MODEL."
echo "Running it on a different model may cause system instability or bootloops."
read -r -p "Do you want to proceed anyway? (y/N) " choice
case "$choice" in
y|Y ) echo "Proceeding with caution..." ;;
* ) echo "Safety abort. Operation cancelled."; exit 1 ;;
esac
fi

# --- Dependency Check (Auto-install jq) ---
if ! command -v jq &> /dev/null; then
echo "Dependency 'jq' not found."
echo "Attempting to install it automatically (requires sudo or Termux)..."

# Termux
if [ -d "/data/data/com.termux" ]; then
pkg update && pkg install -y jq
# Debian/Ubuntu/Mint/Kali
elif command -v apt &> /dev/null; then
sudo apt update && sudo apt install -y jq
# Arch Linux
elif command -v pacman &> /dev/null; then
sudo pacman -S --noconfirm jq
# Fedora/CentOS/RHEL
elif command -v dnf &> /dev/null; then
sudo dnf install -y jq
else
echo "Error: Could not automatically install 'jq'. Please install it manually."
exit 1
fi
fi

# --- Environment Detection
if [ -d "/data/data/com.termux" ] || [ -f "/system/bin/pm" ]; then
EXEC="pm uninstall -k --user 0"
else
EXEC="adb shell pm uninstall -k --user 0"
fi

# Function to select a configuration file from the Imports folder
function select_import_from_folder() {
local import_dir="../../Imports"

if [ ! -d "$import_dir" ]; then
echo "[!] Error: The directory $import_dir does not exist."
return 1
fi

# Get all .json files in the directory
local files=("$import_dir"/*.json)

# Check if files exist
if [ ! -e "${files[0]}" ]; then
echo"[!] No .json files found in $import_dir."
return 1
fi

echo"--- Available configurations in /Imports ---"
PS3="Select the configuration number to load: "
select opt in "${files[@]}" "Return to main menu"; do
case $opt in
"Return to main menu")
return 1
;;
*)
if [ -f "$opt" ]; then
JSON_FILE="$opt"

echo "----------------------------------------"
echo "Configuration Details:"
echo"Name: $(jq -r '.name // "N/A"' "$opt")"
echo "Description: $(jq -r'.description // "N/A"' "$opt")"
echo "Version: $(jq -r '.version // "N/A"' "$opt")"
echo "----------------------------------------"
read -r -p "Apply this configuration? (y/N): " confirm
if [[ $confirm != "y" && $confirm != "Y" ]]; then
return 1
fi
echo "----------------------------------------"

echo "[+] Configuration successfully selected: $opt"
return 0
else
echo "[!] Invalid selection. Please try again."
fi
;;
esac
done
}

# --- Configuration ---
CONFIG_DIR="../../Configs/S24+"
FILE_T1="$CONFIG_DIR/ruvomain_tier1_stable.json"
FILE_T2="$CONFIG_DIR/ruvomain_tier2_stable.json"
FILE_T3="$CONFIG_DIR/ruvomain_tier3_stable.json"

echo "========================================"
echo "   RUVOMAIN PROTOCOL - DEPLOYMENT      "
echo "========================================"
echo "1) Apply Tier 1 (Safe)"
echo "2) Apply Tier 2 (Balanced)"
echo "3) Apply Tier 3 (Extreme)"
echo "4) Load external JSON from /Imports"
echo "----------------------------------------"
read -r -p "Your choice (1-4): " choice

case $choice in
1) JSON_FILE=$FILE_T1; TIER="Tier 1 (Safe)" ;;
2) JSON_FILE=$FILE_T2; TIER="Tier 2 (Balanced)" ;;
3) JSON_FILE=$FILE_T3; TIER="Tier 3 (Extreme)" ;;
4)
if ! select_import_from_folder; then
echo "Operation cancelled. Returning to main menu..."
exit 1
fi
TIER="ExternalConfiguration ($JSON_FILE)"
;;
*)
echo "Invalid option. Exiting."
exit 1
;;
esac

# Check if the file exists
if [ ! -f "$JSON_FILE" ]; then
echo "Error: File $JSON_FILE not found."
exit 1
fi

# --- Confirmation ---
echo "--- Warning ---"
echo "You are about to apply $TIER."
read -r -p "Are you sure you want to proceed? (y/N): " confirm

if [[ $confirm != "y" && $confirm != "Y" ]]; then
echo "Operation cancelled."
exit 0
fi

echo "--- Deploying: $JSON_FILE ---"

if ! jq -e '.apps' "$JSON_FILE" >/dev/null 2>&1; then
echo "[!] CRITICAL ERROR: The file '$JSON_FILE' is not a valid Ruvomain configuration."
echo "[!] It is missing the required'.apps' key."
exit 1
fi

# --- Execution ---
while read -r pkg; do
echo "Processing: $pkg"
$EXEC "$pkg"
done <<(jq -r '.apps[].packageName' "$JSON_FILE")

echo "========================================"
echo "Operation finished."
