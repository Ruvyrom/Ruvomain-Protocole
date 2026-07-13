For users seeking direct control and automation.

- Automatically detects if it's running via ADB (PC) or directly on the device (Termux).

- Automatically installs jq if missing.

- Choose between Safe, Balanced, and Extreme debloating profiles.

- Transparent, modular, and easy to audit.

- Compatible with Linux distro: Debian/Ubuntu/Mint/Kali, Arch Linux, Fedora/CentOS/RHEL

Prerequisites:

- Platform-Tools installed (for PC).

- jq (The script will attempt an auto-install if missing).

Deployment:

- `git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git`

- Navigate: `cd ./Ruvomain-Protocole/ADB-Termux/devices/S24+`
- Execute:
`chmod +x ruvomain.sh && ./ruvomain.sh`

*Note: If you are on Termux, ensure youhave run `termux-setup-storage` and allowed storage permissions first.*
