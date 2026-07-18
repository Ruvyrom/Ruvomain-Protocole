#!/usr/bin/env bash
# Ruvomain Protocol - Main Interface
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$ROOT_DIR/Core/lib_ruvomain.sh"

show_logo

ensure_dependencies || { log_error "Failed to install jq. Aborting.";exit 1; }

if ! command -v adb &>/dev/null; then
if (whiptail --title "ADB Missing" --yesno "ADB is not detected. Would you like to install it now?" 10 50); then
install_adb

if ! command -v adb &> /dev/null; then
log_error "Installation failed or ADB not found in PATH. Please restart."
exit 1
fi
else
log_error "ADB is required. Exiting."
exit 1
fi
fi

check_model || { log_error "Model verification failed."; exit 1; }

CONFIG_DIR="$ROOT_DIR/Configs/S24+"
FILES=("Tier 1 (Safe)" "$CONFIG_DIR/ruvomain_tier1_stable.json"
"Tier 2 (Balanced)" "$CONFIG_DIR/ruvomain_tier2_stable.json"
"Tier 3 (Extreme)" "$CONFIG_DIR/ruvomain_tier3_stable.json")

CHOICE=$(whiptail --title "RUVOMAIN PROTOCOL" --menu "Select your debloat level:" 15 60 4 \
"1" "${FILES[0]}" \
"2" "${FILES[2]}" \
"3" "${FILES[4]}" 3>&1 1>&2 2>&3)

if[ $? -ne 0 ]; then log_info "Operation cancelled."; exit 0; fi

case $CHOICE in
1) SELECTED_FILE=${FILES[1]} ;;
2) SELECTED_FILE=${FILES[3]} ;;
3) SELECTED_FILE=${FILES[5]} ;;
esac

if (whiptail --title "Confirm" --yesno "Apply configuration?\n\nFile: $SELECTED_FILE" 1050); then
execute_debloat "$SELECTED_FILE"
whiptail --title "Success" --msgbox "Ruvomain Protocol deployment complete." 8 40
else
log_info "Operation aborted by user."
fi
