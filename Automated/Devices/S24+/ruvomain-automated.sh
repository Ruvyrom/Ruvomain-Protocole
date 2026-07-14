#!/usr/bin/env bash

# --- Model verification ---
REQUIRED_MODEL="SM-S926B"
# Detect model locally or via ADB
CURRENT_MODEL=$(getprop ro.product.model 2>/dev/null || adb shell getprop ro.product.model 2>/dev/null)

if [ "$CURRENT_MODEL" != "$REQUIRED_MODEL" ]; then
echo "⚠️ WARNING: Detected device model: $CURRENT_MODEL"
echo "This script is specifically optimized for the $REQUIRED_MODEL."
echo "Running it on a different model may cause system instability or bootloops."
read -p "Do you want to proceed anyway? (y/N) " choice
case "$choice" in
y|Y ) echo "Proceeding with caution..." ;;
* ) echo "Safety abort. Operation cancelled."; exit 1 ;;
esac
fi

# --- Dependency Check (adb) ---
check_dependencies() {
if ! command -v adb &> /dev/null; then
echo "--------------------------------------------------------"
echo "Error: 'adb' not detected."
echo "The Ruvomain Protocol requires Android Platform Tools."
echo "Recommended installation based on your distribution:"
# Termux
if [ -d "/data/data/com.termux" ]; then
pkg update && pkg install -y adb
elif command -v apt &> /dev/null; then
sudo apt update&& sudo apt install -y adb
elif command -v pacman &> /dev/null; then
sudo pacman -S --noconfirm android-tools
elif command -v dnf &> /dev/null; then
sudo dnf install -y android-tools
else
echo "  Please install 'adb' via your distribution's package manager."
fi
echo "--------------------------------------------------------"
exit 1
fi
fi
}

# --- Dependency Check (jq) ---
if ! command -v jq &> /dev/null; then
echo "Dependency 'jq' not found."
echo "Attempting to install it automatically (requires sudo)..."

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

#--- Setup (Temporary directory) ---
WORK_DIR=$(mktemp -d)
BASE_URL="https://raw.githubusercontent.com/Ruvyrom/Ruvomain-Protocole/main/Configs/S24%2B"
echo "Initializing protocol in $WORK_DIR..."

# --- Hardware Connection Check ---
if ! adb get-state > /dev/null 2>&1; then
echo "⚠️ No device detected. Please connect the S24+ and enable USB debugging."
exit 1
fi

# --- Download Resources ---
fetch_resource() {
curl -s "$BASE_URL/$1" -o "$WORK_DIR/$1"
}

fetch_resource "ruvomain_tier1_stable.json"
fetch_resource "ruvomain_tier2_stable.json"
fetch_resource "ruvomain_tier3_stable.json"

# --- Environment Detection
if [ -d "/data/data/com.termux" ] || [ -f "/system/bin/pm" ]; then
EXEC="pm uninstall -k --user 0"
else
EXEC="adb shell pm uninstall -k --user 0"
fi

# --- Configuration ---
FILE_T1="$WORK_DIR/ruvomain_tier1_stable.json"
FILE_T2="$WORK_DIR/ruvomain_tier2_stable.json"
FILE_T3="$WORK_DIR/ruvomain_tier3_stable.json"

echo "========================================"
echo "   RUVOMAIN PROTOCOL - DEPLOYMENT      "
echo "========================================"
echo "1) Apply Tier 1 (Safe)"
echo "2) Apply Tier 2 (Balanced)"
echo "3) Apply Tier 3 (Extreme)"
echo "----------------------------------------"
read -p "Your choice (1-3): " choice

case $choice in
1) JSON_FILE=$FILE_T1; TIER="Tier 1 (Safe)" ;;
2) JSON_FILE=$FILE_T2; TIER="Tier 2 (Balanced)" ;;
3) JSON_FILE=$FILE_T3; TIER="Tier 3 (Extreme)" ;;
*) echo "Invalid choice."; exit 1 ;;
esac

# Check if the file exists
if [ ! -f "$JSON_FILE" ]; then
echo "Error: File $JSON_FILE not found."
exit 1
fi

# --- Confirmation ---
echo "--- Warning ---"
echo "You are about to apply $TIER."
read -p "Are you sure you want to proceed? (y/N): " confirm

if [[ $confirm != "y" && $confirm != "Y" ]]; then
echo "Operation cancelled."
exit 0
fi

echo "--- Deploying: $JSON_FILE ---"

# --- Execution & Log---
LOG_FILE="./ruvomain_history.log"

jq -r '.apps[].packageName' "$JSON_FILE" | while read -r pkg; do
echo "[$(date +'%Y-%m-%d %H:%M:%S')] Processing:$pkg" | tee -a "$LOG_FILE"
$EXEC "$pkg"
done

echo "========================================"
echo "Operation finished."
echo "--------------------------------------------------------"
exit 1
fi
}


1) JSON_FILE=$FILE_T1; TIER="Tier 1 (Safe)" ;;
2) JSON_FILE=$FILE_T2; TIER="Tier 2 (Balanced)" ;;
3) JSON_FILE=$FILE_T3; TIER="Tier 3 (Extreme)" ;;
*) echo "Invalid choice."; exit 1 ;;
esac

# Check if the file exists
if [ ! -f "$JSON_FILE" ]; then
echo "Error: File $JSON_FILE not found."
exit 1
fi

# --- Confirmation ---
echo "--- Warning ---"
echo "You are about to apply $TIER."
read -p "Are you sure you want to proceed? (y/N): " confirm

if [[ $confirm != "y" && $confirm != "Y" ]]; then
echo "Operation cancelled."
exit 0
fi

echo "--- Deploying: $JSON_FILE ---"

# --- Execution & Log---
LOG_FILE="./ruvomain_history.log"

jq -r '.apps[].packageName' "$JSON_FILE" | while read -r pkg; do
echo "[$(date +'%Y-%m-%d %H:%M:%S')] Processing:$pkg" | tee -a "$LOG_FILE"
$EXEC "$pkg"
done

echo "========================================"
echo "Operation finished."
