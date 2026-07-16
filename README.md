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
- [Key results](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-key-results-one-ui-85)
- [Protocol hierarchy](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-protocol-hierarchy)
- [Package List](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Docs/package-list.md)
- [Network & Resource Confinement Layers](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#%EF%B8%8F-network--resource-confinement-layers)
- [Quick start](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#%EF%B8%8F-quick-start)
     > [Methode 1: Shizuku/Canta (Manual Control)](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-methode-1-via-shizuku-and-canta) 

   > [Methode 2 : ADB/Termux scripts](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-methode-2-via-adb-or-termux): 
- **Ruvomain Automated (CLI)**
     > [For Linux and Termux](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#1-ruvomain-automated-cli)

     > [For WSL2](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#%EF%B8%8F-windows-users-wsl2-support)
- **Manual execution:**
     > [(Linux/Termux/macOS)](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#2manual-execution-linuxtermuxmacos),
- [Safety & Auditing](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#%EF%B8%8F-safety--auditing)
- [Monitoring Strategy](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#%EF%B8%8F-monitoring-strategy)
- [Proof of concept](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-proof-of-concept)
- [Interface](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-interface)
- [Current Status](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-current-status)
- [Disclaimer](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#%EF%B8%8F-disclaimer)
- [Community & Credits](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-community--credits)
- [License](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/LICENSE)

---
## 🚀 Key Results (One UI 8.5)
*   **SoT:** **11h+** on a single charge.
*   **Idle Drain:** **~0.2-0.5%/h** (Near-zero).
*   **Thermals:** Stable **~37°C** under mixed load.
*   **Knox Integrity:** **100% Safe** (No root, no bootloader unlocking).

---
## 📦 Protocol Hierarchy
The protocol is modular, allowing users to choose their level of optimization. *Tierslists are provided as standardized defaults, but the architecture is designed for you to edit `tier*.json` files to fit your specific operational requirements.*

You can modify .json files if you want keep a fonctionality in /Configs/S24+ [with this method](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#2manual-execution-linuxtermuxmacos)

| Tier | Strategy| Recommended For |
|:---|:---|:---|
| **Tier 1 (Stable/Conservative)** | Redundancy & Telemetry | All users seeking immediate gains. |
| **Tier 2 (Advanced/Balanced)** | AI Telemetry & Cloud Bloat | Users prioritizing privacy & efficiency. |
| **Tier 3 (Surgical/Extreme)** | Ghost Mode (System Core) | Advanced users building a bare-metal experience. |

The protocol keep `Samsung Camera` and `gallery`, `Dolby Atmos`, `Samsung Screenshot`, `OneUI launcher`.
For privacy, you can block internet connexion (with firewall) for these apps without problem.

**For view packages list and descriptions see the /docs/[package-list.md](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Docs/package-list.md)**

**⚠️ Before use Tier3, you must read /docs/[REMPLACEMENT.md](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Docs/REMPLACEMENT.md)**

---
### 🛡️ Network & Resource Confinement Layers

The Ruvomain Protocol extends beyond basic package removal.
To achieve true hardware sovereignty and operational efficiency, we implement a multi-layered confinement strategy to minimize the device's external footprint:

**- NextDNS** (System-wide DNS Filtering):
Configured directly within Android’s Private DNS settings. This acts as the firstline of defense, neutralizing GAFAM telemetry, ISP-level tracking, and ad-infrastructure requests before they even exit the device.

**- AdGuard Nightly** (Granular Firewall):
Deployed for strict network enforcement. This layer restricts connectivity forapplications that do not require network access, prevents "phoning home" during standby (screen-off), and effectively isolates telemetry-heavy processes to minimize energy footprint and unauthorized background communication.

**- AppOps** (Privilege & Wakelock Management):
Enforces the Principle of Least Privilege. Beyond standard permission stripping, this layer targets system-level wakelocks and hardware sensors to ensure processes remain dormant unless explicitly required by the user. This is critical for preventing unauthorized data access (Clipboard, Sensors, Location, Biometrics) and ensuring maximum hardware idle efficiency.

*By layering these tools, the terminal is transformed from a data-leaking device into a hardened, localized system that obeys only the user's intent.*

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

Note: This project includes a Makefile to facilitate auditability and execution. Run `make audit` to verify the integrity of the scripts.

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
## 🛡️ Safety & Auditing
Transparency is a core pillar.

---
**Recommended approach:**
Instead of uninstalling, we use a "Containment Strategy":

**1.** Set your preferred FOSS keyboard (e.g., HeliBoard) as the default.

**2.** Use AppOps to revoke all permissions (Contacts, Storage, etc.) and restrict background execution for the Samsung Keyboard.

**3.** The package remains present to satisfy system dependencies but is effectively neutralized and isolated.

---
*   **Critical Safeguards:** Do **not** disable packages like `com.sec.location.nsflp2` (GPS) or `com.samsung.android.smartmirroring`(Smart View).
*   **System Integrity:** Avoid removing `com.samsung.android.lool` (Device Care). Disabling it may cause audio stuttering and erratic behavior during app transitions, as ithandles key background resource management.

*   `com.samsung.android.scpm`
SoundAlive/Audio quality issues

*   Any package containing:
`com.samsung.internal.systemui.navbar`:
Navigation issues

*   You can disable but if you want maintain Emergency Alerts, you must not disable the following packages:
`com.google.android.cellbroadcastreceiver`,
`com.google.android.cellbroadcastservice`

*   **Auditing:** Every package included in our tiers is verified for stability. Users are encouraged to inspect the lists in /docs/[package-list.md](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Docs/package-list.md).

---
## 🛠️ Monitoring Strategy

**1. Baseline Consumption (The Point of Origin)**

**Before any modification, you must establish your idle drain.**

>**Action:** Charge your device to 100%. Leave it in deep idle (screenoff, Wi-Fi on, SIM active) for 8 hours (overnight).

>**Measure:** Use AccuBattery.

>**Ruvomain Goal:** Target a drain rate between 0.0% and 0.2% per hour. If you exceed 0.5%, your system is polluted by active telemetry services.

**2. Wakelock Audit (Hunting the Intruders)**

**The primary enemy of battery efficiency is not activeusage; it is the CPU's inability to enter "Deep Sleep."**

>**Tool:** [AppOps](https://appops.rikka.app/) (via [Shizuku](https://shizuku.rikka.app/)).

**Procedure:**

>**1.Identify** system apps requesting the WAKE_LOCK permission.
>
>**2. Monitor** processes preventing the device from sleeping.
>
>**3.Audit:** If anon-essential system app holds active wakelocks in the background, it must be confined or neutralized according to the Protocol tiers.

**3. Network Traffic Analysis (Data Flow)**

**A sovereign system communicates only when the Architect authorizes it.**

>**Tool:** AdGuard (Filtering Log).

**Procedure:**

>**1.** Enable local filtering.
>
>**2.** Run for 1 hour under normal usage.
>
>**3. Audit:** Observe domains contacted by system apps (Samsung, Google, Facebook services).
>
>**4. Action:** If telemetry domains are detected, apply block rules via theintegrated firewall.

**4. Framework Stability (The Guardrail)**

**Never delete blindly. Verify the health ofthe system_server.**

>**Action:** After applying your configuration (Tier 1/2/3), monitor for spontaneous reboots or UI lag.
>
>**Technical Note:** If the Samsung keyboard reinstalls itself, you have compromised framework dependencies.
>
>**Remember:** Never use brute-force deletion.
Apply the "Confinement Strategy"(revoke permissions + restrict execution) rather than deletion.

**🛡️ Protocol Reminder**

**Your audit success is measured by these indicators:**

>**Thermals:** The device remains at ambient temperature during mixed usage.
>
>**SOT (Screen On Time):** A steady progression toward 11h+ (for an S24+).

>Share your results in the comments:
>
>**Model:** (e.g., S24+ S926B)
>
>**Tier applied:** (Tier 1, 2, or 3)
>
>**Idle drain(mAh/h):**
>
>**System observations:** Audit is repetition. The more you clean, the moretransparent the system becomes.

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

## 🧪 Interface:

This is the visual and functional result **Setup: Ruvomain Protocol (SamsungS24+)**

I’ve completely reimagined the One UI experience. The goal was to reachan AOSP-like level of minimalism, responsiveness, and privacy, without sacrificing the hardware-level optimizations of the S24+ or tripping Knox.

**The Architecture:**

**Launcher:** Lawnchair 15 (Customflow for maximum efficiency).

**Icons:** Lawnicons (Material You adaptive).

**UI/System:** Deep customization via Good Lock (Theme Park) for a consistent monochrome/monostyle aesthetic across QS panels, volume sliders, and settings.

**Hardening:** System-level bloat removal and telemetry isolation via the"Ruvomain Protocol" (Shizuku, Canta, AppOps).

**Network:** Adguard + Nextdns, no advertisement, no tracking, no telemetry.

**Weather:** Breezy Weather (Open-source, no telemetry).

**Keyboard:** HeliBoard (Open-source, local-only).

**Apps:** Full migration to the \*\*Fossify Suite\*\* (Phone, Messages, Gallery, Calendar, Calculator).

**Why:** By switching to the Fossify ecosystem, I've eliminated telemetry at the app level. No tracking, no background fluff, just pure functionality. The interface is now unified, silent, and incredibly responsive. Knox remains 100% intact.

**Philosophy:** This isn't just a theme; it's a workflow. By removing the intrusive Samsung services and remapping the UI, I've managed to reduce background activity to near-zero levels. The interface is now"silent," allowing for pure focus.
<img src="assets/launcher.jpg" width="400"><img src="assets/launcher2.jpg" width="400"><img src="assets/quick-settings.jpg" width="400"><img src="assets/quicksettings4.jpg" width="400"><img src="assets/quicksettings3.jpg" width="400">

---
## ✅ Current Status:
Stable environment. No critical system crashes or UI stutters detected in daily driving.

## ⚠️ Disclaimer
*I am not responsible for any issues resulting from system modifications. Always perform a data backup before deployment.*

---
*My other project on github for [Google Pixel6, LineageOS Vanilla 23.2](https://github.com/Ruvyrom/Ruvyrom/tree/main)*

***Stay clean, stay fast, stay Ruvomain.*** 🚀
