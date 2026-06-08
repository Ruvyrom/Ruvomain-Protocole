<p align="center">
<img src="https://img.shields.io/badge/github-repo-blue?logo=github">
<img src="https://img.shields.io/badge/S24+_Exynos-Optimized-brightgreen" alt="Device">
<img src="https://img.shields.io/badge/Status-Stable-blue" alt="Status">
<img src="https://img.shields.io/badge/License-MIT-blueviolet" alt="License">
<img src="https://img.shields.io/badge/OS-Android 16 OneUI 8.5-red" alt="License">
<img src="https://img.shields.io/badge/No-Root-yellow">
<img src="https://img.shields.io/badge/Thermal-Optimized-green">
<img src="https://img.shields.io/badge/Privacy-Focused-purple">
<img src="https://img.shields.io/badge/Shizuku-Powered-orange"><img src="https://img.shields.io/badge/S24+-Debloat-brown">
</p>

![](assets/ruvomain.jpg)

I started this project out of pure necessity. My S24+(Exynos) was constantly running hot and draining battery in standby, despite having 'optimized' settings enabled. I realized that standard user-facing settings are just a facade, the real battery consumption happens behind the scenes, buried in system telemetry and background services.
After 15+ years of tinkering with custom ROMs, I decided to pivot my approach. Instead of flashing a custom OS, I wanted to see how far I could push the stock firmware to its absolute limits of efficiency without breaking Knox or banking apps. This repository is my personal log, my testing ground, and the documentation of my journey to reclaiming my hardware sovereignty.
This hasn't been a linear process. You’ll find notes here on things that went wrong—apps I broke, services that caused bootloops, and configurations that actually increased CPU load instead of reducing it.

# Ruvomain Protocol
**The Industrialized Approach to Android Performance & Privacy.**

The Ruvomain Protocol is a modular, audited, and reproducible architecture designed to maximize hardware efficiency for the Samsung Galaxy S24+ (Exynos 2400) without root access. By eliminating non-essential telemetry and background bloatware, we achieve true "Deep Sleep" states, elite thermal management, and 11h+ SOT.

---

## 🚀 Key Results (One UI 8.5)
*   **SoT:** **11h+** on a single charge.
*   **Idle Drain:** **~0.0%/h** (Near-zero).
*   **Performance:** AnTuTu v11 **~2.1M** (Top 5%).
*   **Thermals:** Stable **~37°C** under mixed load.
*   **Knox Integrity:** **100% Safe** (No root, no bootloader unlocking).

---

## 💡  Philosophy
The conventional approach to "debloating" (manually running random ADB commands) is obsolete. It lacks consistency and is impossible to maintain. **The Ruvomain Protocol** shifts this paradigm by treating system optimization as an **industrialized engineering process**.

We don't "trick" the system; we curate it. By surgically removing non-essential services while maintaining framework stability, we ensure the device performs at its peak potential.

---

## 📦 Protocol Hierarchy
The protocol is modular, allowing users to choose their level of optimization:

| Tier | Strategy| Recommended For |
|:---|:---|:---|
| **Tier 1 (Stable/Conservative)** | Redundancy & Telemetry | All users seeking immediate gains. |
| **Tier 2 (Advanced/Balanced)** | AI Telemetry & Cloud Bloat | Users prioritizing privacy & efficiency. |
| **Tier 3 (Surgical/Extreme)** | Ghost Mode (System Core) | Advanced users building a bare-metal experience. |

*See `/presets` for Canta .json configuration files.*

---

## ⚙️ Quick Start
### 📱 Methode 1: via Shizuku and Canta
1.  **Environment:** Install [Shizuku](https://shizuku.rikka.app/) and[Canta](https://samolego.github.io/Canta/).
2.  **Activate:** Enable Developer Options > Wireless Debugging. Pair Shizuku.
3.  **Deploy:** Import the preferred `.json` file from the `/Presets` folder into Canta.
4.  **Finalize:** Reboot the device.

### 💻 Methode 2: via ADB or Termux
For users seeking direct control and automation.

- Automatically detects if it's running via ADB (PC) or directly on the device (Termux).

- Automatically installs `jq` if missing.

- Choose between Safe, Balanced, and Extreme debloating profiles.

- Transparent, modular, and easy to audit.

- Compatible with Linux distro:
Debian/Ubuntu/Mint/Kali, Arch Linux, Fedora/CentOS/RHEL

1. **Prerequisites:**
- [Platform-Tools](https://developer.android.com/tools/releases/platform-tools) installed (for PC).
- `jq` (The script will attempt an auto-install if missing).

2. **Deployment:**
- Clone the repo: `git clone https://github.com/Ruvyrom/ruvyrom.git`
- Navigate: `cd ruvyrom/ruvomain-adb`
- Execute:
`chmod +x ruvomain.sh && ./ruvomain.sh`
---

## 🛡️ Safety & Auditing
Transparency is a core pillar.
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
Avoid heavy "Good Guardian" suites that introducetheir own background overhead. Use **Direct-Access Monitoring**:
*   **Thermal Guardian:** Install the APK, skipthe suite launcher.
*   **AccuBattery:** Use this to quantify the exact mA drain of specific processes.
*   **Rule:** If the idle discharge rate doesn't drop after a tweak, the optimization is invalid.

---

##👥 Community & Credits
This protocol is a living project.
*   **Validation:** Rigorous cross-verification with [Willie_169](https://github.com/Willie169).
*   **Architecture:** Formal acknowledgment of the Canta workflow by [Samolego](https://samolego.github.io/Canta/).
*   **Community Testing:** Special thanks to @ric69 for empirical field-testing of Tier 1 stability.

---
### 📸 Proof of Concept
<img src="assets/accu-93.jpg" width="400"><img src="assets/battery-s.jpg" width="400"><img src="assets/thermalg.jpg" width="400"> <img src="assets/thermalg-cpu.jpg" width="400"> <img src="assets/thermalg-temp.jpg" width="400">

## 🧪 Interface:
This is the visual and functional result of the Ruvomain Protocol applied to a Samsung S24+ (Exynos 2400). This is not a Custom ROM; it is the Samsung OS, deconstructed and liberated from its servitude.

- **Architecture:** Knox remains intact, no root required.

- **Efficiency:** Telemetry, intrusive AI services, and bloatware removed via logical isolation.

- **Control:** Total network isolation via local firewall (real-time visualization of blocked connection attempts).

- **Result:** Zero latency, optimized battery life, and a clean, pure interface (Lawnchair). When hardware is no longer enslaved to manufacturer servers, it once again becomes a personal tool. Fluidity isn’t a "software update". It’s the result of removing useless background processes.

<img src="assets/launcher.jpg" width="400"><img src="assets/launcher2.jpg" width="400"><img src="assets/quick-settings.jpg" width="400"><img src="assets/quick-settings2.jpg" width="400">

## ✅ Current Status:
Stable environment. No critical system crashes or UI stutters detected in daily driving.

## ⚠️ Disclaimer
*I am not responsible for any issues resulting from system modifications. Always perform a data backup before deployment.*

---
*My other project on github for [Google Pixel6, LineageOS Vanilla 23.2](https://github.com/Ruvyrom/Ruvyrom/tree/main)*

***Stay clean, stay fast, stay Ruvomain.*** 🚀
