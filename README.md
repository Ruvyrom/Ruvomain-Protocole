# Ruvomain Protocol v3

<p align="center">
<img src="https://img.shields.io/github/stars/Ruvyrom/Ruvomain-Protocole" alt="Stars"> &nbsp; <img src="https://img.shields.io/github/forks/Ruvyrom/Ruvomain-Protocole" alt="Forks"> &nbsp; <img src="https://img.shields.io/github/watchers/Ruvyrom/Ruvomain-Protocole" alt="Watchers">
</p>

![](assets/ruvomain.jpg)
<p align="center"> Pure Bash Debloater and system management for Samsung S24+ or other Android devices.</p>

---
<p align="center">
<img src="https://img.shields.io/badge/Status | Stable-%23121011.svg?logo=github&logoColor=white&style=flat-square" alt="Status"> &nbsp; <img src="https://img.shields.io/badge/GitHub-%23121011.svg?logo=github&logoColor=white&style=flat-square"> &nbsp; <img src="https://img.shields.io/badge/Clones | 1557 (14 last days)-%23121011.svg?logo=github&logoColor=white&style=flat-square" alt="Total clones">
</p>
<p align="center">
<img src="https://img.shields.io/badge/| Bash-4EAA25?logo=gnubash&logoColor=fff&style=flat-square">
<!-- <img src="https://img.shields.io/badge/Bash-JSON-black?logo=gnubash&logoColor=f5f5f5"> --> &nbsp; <img src="https://img.shields.io/badge/| JSON-000?logo=json&logoColor=fff&style=flat-square"> &nbsp; <img src="https://img.shields.io/badge/| ADB-3DDC84?logo=android&logoColor=white&style=flat-square"> &nbsp; <img src="https://img.shields.io/badge/| Termux-000000?logo=iterm2&logoColor=fff&style=flat-square" > <!-- <img src="https://img.shields.io/badge/ADB-TERMUX-black?logo=android&logoColor=f5f5f5"> -->
</p>
<p align="center">
<img src="https://img.shields.io/badge/| S24+ Debloat-003087?logo=samsung&style=flat-square" > &nbsp; <img src="https://img.shields.io/badge/| OneUI 8.5-FFC517?logo=samsung&style=flat-square"> &nbsp; <img src="https://img.shields.io/badge/| Exynos Optimized-764ABC?logo=samsung&style=flat-square" alt="Device"> &nbsp; <img src="https://img.shields.io/badge/| Android Debloat-3DDC84?logo=android&logoColor=white&style=flat-square">
</p>
<p align="center">
<img src="https://img.shields.io/badge/No Root-FE7A16?style=flat-square"> &nbsp; <img src="https://img.shields.io/badge/Thermal Optimized-FFB3C7?style=flat-square"> &nbsp; <img src="https://img.shields.io/badge/Privacy Focused-%23FF0000.svg?style=flat-square">
</p>
<p align="center">
<img src="https://img.shields.io/badge/| License MIT-black?logo=conventionalcommits&logoColor=f5f5f5&style=flat-square" alt=License>
</p>

---
After 16 years of messing around with Android modding, I finally got tired of re-running the same ADB commands every time Samsung pushes a security patch or I need to re-provisionmy environment.

I’ve started putting my **Ruvomain-PBD** is a zero-dependency, professional-grade infrastructure for system optimization. Designed for those who demand total sovereignty over their hardware, this protocol replaces bloated middleware (like Shizuku or Canta) with a 100% native Bash execution model.

***Note:***
>This project is maintained manually. I wrote these scripts because I was tired of the bloat on my S24+. No AI fluff, just pure Bash and system-level configuration for people who value their time and privacy.

---
Do you have a specific configuration for your device? Place your JSON file in `/Configs/Imports` and call it directly when running

>**Follow** instructions [here](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main/Configs/Imports) for import JSON file. 

---
Got questions? Reddit is the place to discuss builds.
>[r/Ruvomain](https://www.reddit.com/r/Ruvomain/s/9HlpNjl2M7)
---
<!--### Table of Contents

- [Quick start](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#%EF%B8%8F-quick-start)

**Methode 1:** [ADB/Termux scripts](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-methode-2-via-adb-or-termux): 

<!--[For WSL2](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#%EF%B8%8F-windows-users-wsl2-support)-->

<!--- **1.2 - Manual execution (script v2):**
     > [Linux/Termux/macOS](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#2manual-execution-linuxtermuxmacos),

- [Proof of concept](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-proof-of-concept)
  
- [Current Status](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-current-status)
  
- [Disclaimer](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#%EF%B8%8F-disclaimer)
  
- [Community & Credits](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-community--credits)
  
- [License](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/LICENSE)-->

## Documentation
To gain a deeper understanding of the technical and operational aspects of the protocol, please refer to the following files located in the `/Docs` directory:

- [Protocol Hierarchy](/Docs/Protocol-Hierarchy.md) 
>An overview of the protocol's global architecture.

<!--- [Using the Makefile](/Docs/Using-the-Makefile.md)
>A comprehensive guide to the secure control interface.-->

- [JSON files importation](/Configs/Imports/README.md)
>How to import your personnal .json list files (for S24+ or other devices) with v2 version of Manual Execution script.

- [Network & Resource Confinement](/Docs/Network-&-Resource-Confinement-Layers.md)
>Technical details on system hardening and resource management.

- [Package List](Docs/package-list.md)
>A detailed list of components targeted by the protocol.

- [Replacement](/Docs/Remplacement.md)
>Documentation regarding software substitution processes and procedures.Users on different hardware or firmware versions should exercise caution and verify package dependencies before execution.

- [Interface Setup](/Docs/Interface-Setup.md)
>A guide to achieving an AOSP-like aestheticand maximum operational efficiency while retaining native Samsung system optimizations.

- [Monitoring Strategy](/Docs/Monitoring-Strategy.md)
>Methodologies for analyzing system behavior, battery drain, and network telemetry to maintain long-term stability.

- [Safety & Auditing](Docs/Safety-&-Auditing.md)
>Information regarding code transparency, audit processes, and system integrity maintenance.

---
Got questions? Reddit is the place to discuss builds.
>[r/Ruvomain](https://www.reddit.com/r/Ruvomain/s/9HlpNjl2M7)

---
## ⚙️ Quick Start
**Disconnect Samsung account before using tier 2 and 3 in script and for more privacy.**

### Ruvomain-PBD
Local, offline-capable usage.

Enable USB Debugging on your phone: 
>
>Settings > About Phone > Tap "Build Number" 7 times
>
>Settings > Developer Options > Enable "USB Debugging"
>
>Connect your phone to your PC via USB

### 🐧 For Linux users:
1. **Prerequisites:**
  
- `adb` (The script will attempt an android-tools auto-installation if missing).

2. **Deployment:**
- **Clone the repo:** `git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git`

- **(Optional) [import](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/README.md) your personnal configuration file (for s24+ or other Android devices) or Modify** ruvomain_tier*_stable.json in `/Configs/S24+`

- **Navigate:** `cd ./Ruvomain-Protocole/ruvomain-pdb/`

- **Execute:**
`chmod +x ruvomain.sh && ./ruvomain.sh`

### 📱 For Termux users
- **Grant Storage Access:** `termux-setup-storage` (Accept the permission prompt)

- **Deploy:** Follow the same steps as the [Linux](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-for-linux-users) deployment above.

### 🍎 For MacOS users:
1. Install [Homebrew](https://brew.sh/) if you haven't already.

2. **Install ADB:**
`brew install git android-platform-tools`

3. **Clone the protocol:**
`git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git`
`cd Ruvomain-Protocole/ruvomain-pdb`

4. **Verify device connection:**
`adb devices`
*(If "unauthorized", check your phonescreen and tap "Always allow")*

5. **(Optional) [import](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/README.md) your personnal configuration file (for s24+ or other Android devices) or Modify** ruvomain_tier*_stable.json in `/Configs/S24+`

6. **Execute:**
`cd ./Ruvomain-Protocole/ADB-Termux/devices/S24+`
`./ruvomain.sh`

5.  **Finalize:** Reboot the device.

---
"Surgical Minimalism" is the art of achieving maximum efficiency through the smallest possible codebase. By eliminating external dependencies, we reduce the system's attack surface and ensureabsolute transparency.

*   **Zero-Dependency:** No Java, no middleware, no pre-compiled binaries. Just pure shell.

*   **Auditable:** Every line of code is human-readable. You own the process from end to end.

*   **Autonomous:** The protocol executes, performs the surgical strike, and terminates. No resident services (daemons) remain in the background.

---
## ⚖️ Comparison Matrix

| Feature | Standard Approach (Canta/Shizuku)| **Ruvomain-PBD** |
| :--- | :--- | :--- |
| **Dependencies** | Java, Shizuku, Canta, `jq` | **None (Zero-Dependency)** |
| **Memory Footprint** | Permanent (Active service) | **None (One-time execution)** |
| **Auditability** | Limited (Black-box) | **Total (Native Bash)** |
| **Complexity** | High(Multi-layered) | **Minimalist (Surgical)** |

---
## 🚀 Technical Architecture

The core of **Ruvomain-PBD** is `json-walk`, an event-driven (SAX-style) parser written in pure Bash. It processesyour configurations natively, ensuring compatibility across Linux, Termux, and Android without requiring external binaries like `jq`.

---
Got questions? Reddit is the place to discuss builds.
>[r/Ruvomain](https://www.reddit.com/r/Ruvomain/s/9HlpNjl2M7)

---
### 👥 Community & Credits
For support, discussions, and the latest news on the Ruvomain Protocol, join our Community:
>[Reddit](https://www.reddit.com/r/Ruvomain/s/9HlpNjl2M7)
>[Telegram Channel](https://t.me/ruvomain)

*   "100% Bash Parser for JSON" - thanks to [smmoosavi](https://github.com/smmoosavi/json-walk) for json-walk.
*   **Validation:** Rigorous cross-verification with [Willie_169](https://github.com/Willie169).
*   **Architecture:** Formal acknowledgment of the Canta workflow by [Samolego](https://samolego.github.io/Canta/).
*   **Community Testing:** Special thanks to @ric69 for empirical field-testing of Tier 1 stability.

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
