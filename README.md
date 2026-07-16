<p align="center">
<img src="https://img.shields.io/badge/Status-Stable-blue" alt="Status"><img src="https://img.shields.io/badge/github-repo-blue?logo=github"><img src="https://img.shields.io/badge/OneUI-8.5-violet"><img src="https://img.shields.io/badge/S24+-Debloat-brown"><img src="https://img.shields.io/badge/Exynos-Optimized-brightgreen" alt="Device">
<img src="https://img.shields.io/badge/No-Root-yellow">
<img src="https://img.shields.io/badge/Thermal-Optimized-green">
<img src="https://img.shields.io/badge/Privacy-Focused-purple">
<img src="https://img.shields.io/badge/Shizuku-Powered-orange"><img src="https://img.shields.io/badge/ADB-TERMUX-brightblue"><img src="https://img.shields.io/badge/License-MIT-blueviolet" alt="License">
</p>

![](assets/ruvomain.jpg)<p align="center"><img src="assets/S24+.jpg"> 
</p>

After 16 years of messing around with Android modding, I finally got tired of re-running the same ADB commands every time Samsung pushes a security patch or I need to re-provisionmy environment.

I’ve started putting my cleanup and confinement tools into this modular protocol. The goal is to keep it portable, versioned, and auditable, specifically to avoid root,as Knox is too sensitive on the S24+ to mess with.

Links:
[Reddit](https://www.reddit.com/r/Ruvomain/s/9HlpNjl2M7)

### Table of Contents
- [Quick start](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#%EF%B8%8F-quick-start)
     > [Methode 1: Shizuku/Canta (Manual Control)](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-methode-1-via-shizuku-and-canta) 

   > [Methode 2 : ADB/Termux scripts](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-methode-2-via-adb-or-termux): 
- **Ruvomain Automated (CLI)**
     > [For Linux and Termux](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#1-ruvomain-automated-cli)

     > [For WSL2](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#%EF%B8%8F-windows-users-wsl2-support)
- **Manual execution:**
     > [(Linux/Termux/macOS)](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#2manual-execution-linuxtermuxmacos),
- [Proof of concept](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-proof-of-concept))
- [Current Status](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-current-status)
- [Disclaimer](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#%EF%B8%8F-disclaimer)
- [Community & Credits](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-community--credits)
- [License](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/LICENSE)

## Documentation
To gain a deeper understanding of the technical and operational aspects of the protocol, please refer to the following files located in the `/Docs` directory:

- [Protocol Hierarchy](/Docs/Protocol-Hierarchy.md): An overview of the protocol's global architecture.
- [Using the Makefile](/Docs/Using-the-Makefile.md): A comprehensive guide to the secure control interface.
- [Network & Resource Confinement](/Docs/Network-&-Resource-Confinement-Layers.md): Technical details on system hardening and resource management.
- [Package List](Docs/package-list.md): A detailed list of components targeted by the protocol.
- [Replacement](/Docs/Remplacement.md): Documentation regarding software substitution processes and procedures.Users on different hardware or firmware versions should exercise caution and verify package dependencies before execution.
- [Interface Setup](/Docs/Interface-Setup.md): A guide to achieving an AOSP-like aestheticand maximum operational efficiency while retaining native Samsung system optimizations.
- [Monitoring Strategy](/Docs/Monitoring-Strategy.md): Methodologies for analyzing system behavior, battery drain, and network telemetry to maintain long-term stability.
- [Safety & Auditing](Docs/Safety-&-Auditing.md): Information regarding code transparency, audit processes, and system integrity maintenance.

---
## ⚙️ Quick Start
**Disconnect Samsung account before using tier 2 and 3 in script and for more privacy.**

### 📱 Methode 1: via Shizuku and Canta
1.  **Environment:** Install [Shizuku](https://shizuku.rikka.app/) and[Canta](https://samolego.github.io/Canta/).
2.  **Activate:** Enable Developer Options > Wireless Debugging. Pair Shizuku.
3.  You can **modify** .json files if you want keep a fonctionality in `/Configs/S24+`
4.  **Deploy:** Import the preferred `.json` file from the Configs/[YOUR_MODEL](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main/Configs/S24+) folder into Canta.
5.  **Finalize:** Reboot the device.

---
### 💻 Methode 2: via ADB or Termux
For users seeking direct control and automation.

Note: This project includes a Makefile to facilitate auditability and execution. Run `make audit` to verify the integrity of the scripts. [Using the Makefile](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Docs/Using-the-Makefile.md)

### 1. Ruvomain Automated (CLI)
**Quick & Automatic Execution
Execute directly in memory (no permanent installation required):**

**Note:** Ensure `curl` is installed (`pkg install curl` in Termux).

`bash <(curl -s https://raw.githubusercontent.com/Ruvyrom/Ruvomain-Protocole/main/Automated/Devices/S24%2B/ruvomain-automated.sh)`

or

`curl -LO https://raw.githubusercontent.com/Ruvyrom/Ruvomain-Protocole/main/Automated/Devices/S24%2B/ruvomain-automated.sh && chmod +x ruvomain-automated.sh && ./ruvomain-automated.sh`

**Key Features:**

**•Model Validation:** Automatic device detection (enforces secure deployment).

**•Dependency Management:** Automated setup of required tools (adb, jq).

**•Surgical Minimalism:** Utilizes mktemp for isolated execution. No system residue left behind.

**•Tiered Debloating:** Choice of strictness levels (Tier 1, 2, or 3) based on user requirements.

**•Always Up-to-Date:** The script dynamically fetches the latest configuration files from this repository at each run, ensuring you always have the most optimized and secure settings without manual intervention.

**•Auditability:** Comprehensive execution logging (ruvomain_history.log) for full transparency.

Once the process is complete, verify the operations performed by inspecting the log file: `cat ruvomain_history.log`

### 🖥️ Windows Users (WSL2 Support)

To use the automated script via WSL2, you must bridge your USB connection:

**1.Install** usbipd-win.

**2.In PowerShell (Admin):** `usbipd bind --busid <BUSID>` (find your device with usbipd list).

**3.Attach:** `usbipd attach --wsl --busid <BUSID>`.

**4.Run the script** directly inside your WSL terminal.

[Instructions for execute automated script](https://github.com/Ruvyrom/Ruvomain-Protocole#1-ruvomain-automated-cli) 

or script below (for Linux commands) 👇

---
### 2.Manual Execution (Linux/Termux/macOS)
For local, offline-capable usage.

Note: This project includes a Makefile to facilitate auditability and execution. Run `make audit` to verify the integrity of the scripts. [Using the Makefile](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Docs/Using-the-Makefile.md)

With this script, you can modify [ruvomain_tier*_stable.json](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main/Configs/S24%2B) files in your convenience before applying:

### 🐧 For Linux users:
1. **Prerequisites:**
- [Platform-Tools](https://developer.android.com/tools/releases/platform-tools) installed (for PC). Or `sudo apt update && sudo apt install android-sdk-platform-tools` in terminal on Debian for exemple.
  
- `jq` (The script will attempt an auto-install if missing).

2. **Deployment:**
**- Clone the repo:** `git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git`

**- (Optional) Modify**
ruvomain_tier*_stable.json in `/Configs/S24+`

**- Navigate:** `cd ./Ruvomain-Protocole/ADB-Termux/devices/S24+`

**- Execute:**
`chmod +x ruvomain.sh && ./ruvomain.sh`

### 📱 For Termux users:

**- Install dependencies:** `pkg update && pkg install git android-tools jq2`.

**- Grant Storage Access:** `termux-setup-storage` (Accept the permission prompt)

**- Deploy:** Follow the same steps as the [Linux](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-for-linux-users) deployment above.

### 🍎 For MacOS users:
1. Install [Homebrew](https://brew.sh/) if you haven't already.

2. **Install dependencies:**
`brew install git jq android-platform-tools`

3.**Clone the protocol:**
`git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git`
`cd Ruvomain-Protocole`

4. **Verify device connection:**
`adb devices`
*(If "unauthorized", check your phonescreen and tap "Always allow")*

5. **Customize (Optional):**
- Navigate to `/Configs/S24+`
- Modify any `ruvomain_tier*_stable.json` as you wish.

6. **Execute:**
`cd ./Ruvomain-Protocole/ADB-Termux/devices/S24+`
`./ruvomain.sh`

**Key Features:**

- Automatically installs `jq` if missing. *(not for MacOS)*

- Choose between Safe, Balanced, and Extreme debloating profiles.

- Transparent, modular, and easy to audit.

- Native support for Linux, macOS, and Termux. Works flawlessly on WSL (WindowsSubsystem for Linux). No Windows-specific dependencies required.

---
### 👥 Community & Credits
For support, discussions, and the latest news on the Ruvomain Protocol, join our Telegram channel:
[Reddit](https://www.reddit.com/r/Ruvomain/s/9HlpNjl2M7)
[Telegram Channel](https://t.me/ruvomain)

*   **Validation:** Rigorous cross-verification with [Willie_169](https://github.com/Willie169).
*   **Architecture:** Formal acknowledgment of the Canta workflow by [Samolego](https://samolego.github.io/Canta/).
*   **Community Testing:** Special thanks to @ric69 for empirical field-testing of Tier 1 stability.

This protocol is a living project. You can create and adapt this for other devices. 

---
### 📸 Proof of Concept
<img src="assets/accu-93.jpg" width="400"><img src="assets/battery2.jpg" width="400"><img src="assets/thermalg2.jpg" width="400"> <img src="assets/thermalg-cpu.jpg" width="400"> <img src="assets/thermalg-temp.jpg" width="400"> <img src="assets/ram1.jpg" width="400">

---
## ✅ Current Status:
Stable environment. No critical system crashes or UI stutters detected in daily driving.

## ⚠️ Disclaimer
*I am not responsible for any issues resulting from system modifications. Always perform a data backup before deployment.*

---
*My other project on github for [Google Pixel6, LineageOS Vanilla 23.2](https://github.com/Ruvyrom/Ruvyrom/tree/main)*

***Stay clean, stay fast, stay Ruvomain.*** 🚀
