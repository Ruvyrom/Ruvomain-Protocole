#!/usr/bin/env bash

# --- Model verification ---
REQUIRED_MODEL="SM-S926B"
CURRENT_MODEL=$(getprop ro.product.model 2>/dev/null || adb shell getprop ro.product.model 2>/dev/null)

if [[ "$CURRENT_MODEL" != "$REQUIRED_MODEL" ]]; then
echo "⚠️ WARNING:Detected device model: $CURRENT_MODEL"
echo "This script is specifically optimized for $REQUIRED_MODEL."

read -r -p "Do you want to proceed anyway? (y/N) " choice

if [[ ! "$choice" =~ ^[Yy]$ ]]; then
echo "Safety abort. Operation cancelled."
exit1
fi
else
echo "✅ Device model $CURRENT_MODEL verified. Proceeding..."
fi

install_deps() {
echo "🔍 Auditing dependencies..."
if command -v pkg &> /dev/null; then PKG_MGR="pkg"
elif command -v apt &> /dev/null; then PKG_MGR="apt"
elif command -v dnf &> /dev/null; then PKG_MGR="dnf"
elif command -v pacman &> /dev/null; then PKG_MGR="pacman"
else echo "❌ Error: Package manager not recognized."; exit 1; fi

case $PKG_MGR in
pkg)    $PKG_MGR install -y android-tools jq ;;
apt)    sudo $PKG_MGR update && sudo $PKG_MGR install -y adb jq ;;
dnf)    sudo $PKG_MGR install -y android-tools jq ;;
pacman) sudo $PKG_MGR -S --noconfirm android-tools jq ;;
esac
echo "✅ Dependencies ready."
}

# --- Initialization ---
install_deps
WORK_DIR=$(mktemp -d)
BASE_URL="https://raw.githubusercontent.com/Ruvyrom/Ruvomain-Protocole/main/Configs/S24%2B"

# --- Environment & Connection ---
if ! adb get-state > /dev/null 2>&1 && [ ! -d "/data/data/com.termux" ]; then
echo "⚠️ No device detected. Ensure USB debugging is ON."
exit 1
fi

if [ -d "/data/data/com.termux" ] || command -v termux-setup-storage &> /dev/null; then
EXEC="pm uninstall -k --user 0"
else
EXEC="adb shell pm uninstall -k --user 0"
fi

# --- Download Resources ---
echo "Downloading configurations..."
for tier in stable_t1 stable_t2 stable_t3; do
curl -sSf "$BASE_URL/ruvomain_${tier}.json" -o "$WORK_DIR/ruvomain_${tier}.json"
done

#--- Menu ---
echo "========================================"
echo "   RUVOMAIN PROTOCOL - DEPLOYMENT"
echo "========================================"
echo "1) Tier 1 (Safe) | 2) Tier 2 (Balanced) | 3) Tier 3 (Extreme)"
read -r -p "Choice (1-3): " choice

case $choice in
1) JSON_FILE="$WORK_DIR/ruvomain_stable_t1.json"; TIER="Tier1" ;;
2) JSON_FILE="$WORK_DIR/ruvomain_stable_t2.json"; TIER="Tier 2" ;;
3) JSON_FILE="$WORK_DIR/ruvomain_stable_t3.json"; TIER="Tier 3" ;;
*) echo "Invalid."; exit 1 ;;
esac

# --- Execution ---
read -r -p "Deploy $TIER? (y/N):" confirm
[[ "$confirm" != "y" && "$confirm" != "Y" ]] && { echo "Cancelled."; exit 0; }

LOG_FILE="./ruvomain_history.log"
jq -r '.apps[].packageName' "$JSON_FILE" | while read -r pkg; do
echo "[$(date +'%Y-%m-%d %H:%M:%S')] Processing: $pkg" | tee -a "$LOG_FILE"
$EXEC "$pkg"
done

echo "========================================"
echo "Operation finished. Log: $LOG_FILE"
if ! adb get-state > /dev/null 2>&1 && [ ! -d "/data/data/com.termux" ]; then
echo "⚠️ No device detected. Ensure USB debugging is ON."
exit 1
fi

if[ -d "/data/data/com.termux" ] || command -v termux-setup-storage &> /dev/null; then
EXEC="pm uninstall -k --user 0"
else
EXEC="adb shell pm uninstall -k --user 0"
fi

# --- Download Resources ---
echo "Downloading configurations..."
for tier in stable_t1 stable_t2 stable_t3; do
curl -sSf "$BASE_URL/ruvomain_${tier}.json" -o "$WORK_DIR/ruvomain_${tier}.json"
done

#--- Menu ---
echo "========================================"
echo "   RUVOMAIN PROTOCOL - DEPLOYMENT"
echo "========================================"
echo "1) Tier 1 (Safe) | 2) Tier 2 (Balanced) | 3) Tier 3 (Extreme)"
read -p "Choice (1-3): " choice

case $choice in
1) JSON_FILE="$WORK_DIR/ruvomain_stable_t1.json"; TIER="Tier1" ;;
2) JSON_FILE="$WORK_DIR/ruvomain_stable_t2.json"; TIER="Tier 2" ;;
3) JSON_FILE="$WORK_DIR/ruvomain_stable_t3.json"; TIER="Tier 3" ;;
*) echo "Invalid."; exit 1 ;;
esac

# --- Execution ---
read -p "Deploy $TIER? (y/N):" confirm
[[ "$confirm" != "y" && "$confirm" != "Y" ]] && { echo "Cancelled."; exit 0; }

LOG_FILE="./ruvomain_history.log"
jq -r '.apps[].packageName' "$JSON_FILE" | while read -r pkg; do
echo "[$(date +'%Y-%m-%d %H:%M:%S')] Processing: $pkg" | tee -a "$LOG_FILE"
$EXEC "$pkg"
done

echo "========================================"
echo "Operation finished. Log: $LOG_FILE"
