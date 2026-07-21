#!/usr/bin/env bash
# Ruvomain ADB-Termux Debloater (Pure Bash / Zero-Dependency)
# Version 3.0.0 (Refactored for Ruvomain Protocol - Surgical Minimalism)
# Created by Ruvyrom
set -euo pipefail

# --- Library Injection ---
LIB_PATH="$(dirname "$0")/lib/json-walk.sh"
if [ ! -f "$LIB_PATH" ]; then
echo "[!] CRITICAL: lib/json-walk.sh not found. Infrastructure integrity compromised."
exit 1
fi
source "$LIB_PATH"

if [[ ! -x "$(dirname "$0")/lib/json-walk.sh" ]]; then
chmod +x "$(dirname "$0")/lib/json-walk.sh"
fi

# --- Styles---
BOLD='\033[1m'
CYAN='\033[0;36m'
NC='\033[0m'

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

show_logo
echo -e "${CYAN}${BOLD}Ruvomain-PBD | Pure Bash Debloater${NC}"
echo "------------------------------------------"
CURRENT_MODEL=$(getprop ro.product.model2>/dev/null || adb shell getprop ro.product.model 2>/dev/null)
echo-e "Device detected: ${BOLD}${CURRENT_MODEL:-Unknown}${NC}"
echo "------------------------------------------"
 
if command -v adb &> /dev/null; then
log_info "Installing ADB"
if [ -d "/data/data/com.termux" ]; then pkg install -y android-tools
elif command -v apt &> /dev/null; then sudo apt install -y android-tools-adb
elif command -v pacman &> /dev/null; then
sudo pacman -S --noconfirm android-tools
elif command -v dnf &> /dev/null; then
sudo dnf install -y android-tools
else return 1; fi
fi
}

# --- Infrastructure Helpers (Visitors) ---
get_json_val() {
local file="$1"
local target_key="$2"
local found="N/A"

visitor() {
if [[ "$1" == "key" && "$2" == "$target_key" ]]; then
STATE="capture"
elif [[ "$STATE" == "capture" && "$1" == "string" ]]; then
found="$2"
STATE="done"
fi
}
STATE="idle"
json_walk "$(<"$file")" visitor
echo "$found"
}

get_packages() {
local file="$1"
PACKAGES=()

pkg_visitor() {
if [[ "$1" == "key" && "$2" == "packageName" ]]; then
STATE="capturing"
elif [[ "$STATE" == "capturing" && "$1" == "string" ]]; then
PACKAGES+=("$2")
STATE="idle"
fi
}
STATE="idle"
json_walk "$(<"$file")" pkg_visitor
}

# --- Environment Setup
if [ -d "/data/data/com.termux" ] || [ -f "/system/bin/pm" ]; then
EXEC="pm uninstall -k --user 0"
else
EXEC="adb shell pm uninstall -k --user 0"
fi

# --- Menu Logic ---
function select_import_from_folder() {
local import_dir="../../Configs/Imports"
[ ! -d "$import_dir" ] && echo"[!] Folder not found." && return 1
local files=("$import_dir"/*.json)
[ ! -e "${files[0]}" ] && echo "[!] No configs found." && return 1

select opt in "${files[@]}" "Return to main menu"; do
if [[ "$opt" == "Return to main menu" ]]; then return 1; fi
if [ -f "$opt" ]; then
JSON_FILE="$opt"
echo "--- Configuration Details ---"
echo "Name: $(get_json_val "$opt""name")"
echo "Version: $(get_json_val "$opt" "version")"
read -r -p "Apply? (y/N): " confirm
[[ "$confirm" == [yY] ]] && return 0 || return 1
fi
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
TIER="External Configuration ($JSON_FILE)"
;;
*)
echo "Invalid option. Exiting."
exit 1
;;
esac

# --- Final Execution ---
echo "[+] Deploying configuration: $JSON_FILE"

SUCCESS_COUNT=0
FAILED_COUNT=0

get_packages "$JSON_FILE"

if [[ "$(get_json_val "$JSON_FILE" "apps")" == "N/A" ]]; then
echo "[!] CRITICAL: Invalid Ruvomain file (missing 'apps' key)."
exit 1
fi

for pkg in "${PACKAGES[@]}"; do
echo -n "Processing: $pkg ... "

if $EXEC "$pkg" > /dev/null 2>&1; then
echo "[OK]"
((SUCCESS_COUNT++))
else
echo "[FAILED]"
((FAILED_COUNT++))
fi
done

echo "========================================"
echo "Report:"
echo "  Packages removed: $SUCCESS_COUNT"
echo "  Failures: $FAILED_COUNT"
echo

echo "========================================"
echo "Operation finished. Sovereignty restored."
