#!/usr/bin/env bash
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

#--- Model verification ---
REQUIRED_MODEL="SM-S926B"
CURRENT_MODEL=$(getprop ro.product.model 2>/dev/null || adb shell getprop ro.product.model 2>/dev/null)

if [[ "$CURRENT_MODEL" != "$REQUIRED_MODEL" ]]; then
echo "⚠️ WARNING: Detected devicemodel: $CURRENT_MODEL"
echo "This script is specifically optimized for $REQUIRED_MODEL."
read -r -p "Do you want to proceed anyway? (y/N) " choice
if [[ ! "$choice" =~ ^[Yy]$ ]]; then
echo "Safety abort. Operation cancelled."
exit 1
fi
else
echo "✅ Device model $CURRENT_MODEL verified. Proceeding..."
fi

# --- Dependencies & Env ---
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
}

install_deps
WORK_DIR=$(mktemp -d)
BASE_URL="https://raw.githubusercontent.com/Ruvyrom/Ruvomain-Protocole/main/Configs/S24%2B"

if ! adb get-state > /dev/null 2>&1 && [ ! -d "/data/data/com.termux" ]; then
echo "⚠️ No device detected. Ensure USB debuggingis ON."
exit 1
fi

EXEC=$([ -d "/data/data/com.termux" ] || [ -f "/system/bin/pm" ] && echo "pm uninstall -k --user 0"|| echo "adb shell pm uninstall -k --user 0")

# --- Download & Menu ---
echo "Downloading configurations..."
for tier in stable_t1 stable_t2 stable_t3; do
curl-sSf "$BASE_URL/ruvomain_${tier}.json" -o "$WORK_DIR/ruvomain_${tier}.json"
done

echo "========================================"
echo "   RUVOMAIN PROTOCOL -DEPLOYMENT"
echo "========================================"
echo "1) Tier 1 (Safe) |2) Tier 2 (Balanced) | 3) Tier 3 (Extreme)"
read -r -p"Choice (1-3): " choice

case $choice in
1) JSON_FILE="$WORK_DIR/ruvomain_stable_t1.json"; TIER="Tier 1" ;;
2) JSON_FILE="$WORK_DIR/ruvomain_stable_t2.json"; TIER="Tier 2";;
3) JSON_FILE="$WORK_DIR/ruvomain_stable_t3.json"; TIER="Tier 3" ;;
*) echo "Invalid choice."; exit 1 ;;
esac

# --- Execution ---
read -r -p "Deploy $TIER? (y/N): " confirm
[[ "$confirm" =~ ^[Yy]$ ]] || { echo "Cancelled."; exit 0; }

LOG_FILE="./ruvomain_history.log"
jq -r '.apps[].packageName' "$JSON_FILE" | while read -r pkg; do
echo "[$(date +'%Y-%m-%d %H:%M:%S')] Processing: $pkg"| tee -a "$LOG_FILE"
$EXEC "$pkg"
done

echo "========================================"
echo "Operation finished. Log: $LOG_FILE"
rm -rf "$WORK_DIR"
