#!/usr/bin/env bash
# Ruvomain Library - Core Logic

log_info() { echo-e "\e[32m[INFO]\e[0m $1"; }
log_warn() { echo -e "\e[33m[WARN]\e[0m $1"; }
log_error() { echo -e "\e[31m[ERROR]\e[0m $1"; }

show_logo() {
cat <<- "EOF"
____                                    _
/ __ \__  ___   ______  ____ ___  ____ _(_)___
/ /_/ / / / / | / / __ \/ __ `__ \/ __ `/ / __ \
/ _, _/ /_/ /| |/ / /_/ / / / / / //_/ / / / / /
/_/ |_|\__,_/ |___/\____/_/ /_/ /_/\__,_/_/_/ /_/
/ __ \_________  / /_____  _________  / /__
/ /_/ / ___/ __ \/ __/ __ \/ ___/ __ \/ / _ \
/ ____/ /  / /_/ / /_/ /_/ / /__/ /_/ / /  __/
/_//_/   \____/\__/\____/\___/\____/_/\___/
EOF
}

check_model() {
local required="SM-S926B"
local current=$(getprop ro.product.model 2>/dev/null || adb shell getprop ro.product.model)

if[ "$current" != "$required" ]; then
if (whiptail --title "Device Mismatch" --yesno "Detected:$current\nRequired: $required\nContinue anyway?" 10 50); then
return0
else
return 1
fi
fi
return 0
}

install_adb() {
log_info "Installing ADB..."
if[ -d "/data/data/com.termux" ]; then
pkg install -y android-tools
elif command -v apt &> /dev/null; then
sudo apt update && sudo apt install -y android-tools-adb
elif command -v pacman &> /dev/null; then
sudo pacman -S --noconfirm android-tools
elif command -v dnf &> /dev/null; then
sudo dnf install -y android-tools
else
log_error "Could not auto-install ADB. Please install it manually for your distro."
return 1
fi
log_info "ADB installed successfully."
}

ensure_dependencies() {
if ! command -v jq &> /dev/null; then
log_info "Installing dependencies..."
if [ -d "/data/data/com.termux" ]; then pkg install -y jq
elif command -v apt &> /dev/null; then sudo apt install -y jq
elif command -v pacman &> /dev/null; then
sudo pacman -S --noconfirm jq
# Fedora/CentOS/RHEL
elif command -v dnf &> /dev/null; then
sudo dnf install -y jq
else return 1; fi
fi
}

execute_debloat() {
local json_file=$1
local executor
if [ -d "/data/data/com.termux" ] || [ -f "/system/bin/pm" ]; then
executor="pm uninstall -k --user 0"
else
executor="adb shell pm uninstall -k --user 0"
fi

log_info "Deploying configuration from: $json_file"

if[[ ! -f "$json_file" ]]; then
log_error "Config file not found: $json_file"
return 1
fi

while read -r pkg; do
[ -z "$pkg" ] && continue
log_info "Removing: $pkg"
$executor "$pkg"
done < <(jq -r '.apps[].packageName' "$json_file")
}
