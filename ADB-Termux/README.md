### Manual Execution (Linux/Termux/macOS)
**For local, offline-capable usage:**

- Automatically detects if it's running via ADB (PC) or directly on the device (Termux).

- Automatically installs jq if missing.

- Choose between Safe, Balanced, and Extreme debloating profiles.

- Transparent, modular, and easy to audit.

- Compatible with Linux distro: Debian/Ubuntu/Mint/Kali, Arch Linux, Fedora/CentOS/RHEL

### For Linux users:
**Prerequisites:**

- Platform-Tools installed (for PC).

- jq (The script will attempt an auto-install if missing).

**Deployment:**

- Clone the repo: `git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git`

- Navigate: `cd ./Ruvomain-Protocole/ADB-Termux/devices/S24+`
- Execute:
`chmod +x ruvomain.sh && ./ruvomain.sh`

### For Termux users:
**- Install dependencies:** `pkg update && pkg install git android-tools jq2`.

**- Grant Storage Access:** `termux-setup-storage` (Accept the permission prompt)

**- Deploy:** Follow the same steps as the Linux deployment above.

### For MacOS users:
1. Install [Homebrew](https://brew.sh/) if you haven't already.
2.Install `jq` and `adb`: `brew install jq android-platform-tools`
3. Go to `./Ruvomain-Protocole/ADB-Termux/S24+`
4. Run the script: `./ruvomain.sh`
