![](assets/ruvomain.jpg)

# Ruvomain Protocol
**The Industrialized Approach to Android Performance & Privacy.**

The Ruvomain Protocol is a modular, audited, and reproducible architecture designed to maximize hardware efficiency for the Samsung Galaxy S24+ (Exynos 2400) without rootaccess. By eliminating non-essential telemetry and background bloatware, we achieve true "Deep Sleep" states, elite thermal management, and 11h+ SOT.

---

## 🚀 Key Results (One UI 8.5)
*   **SoT:** **11h+** on a single charge.
*   **Idle Drain:****~0.0%/h** (Near-zero).
*   **Performance:** AnTuTu v11 **~2.1M** (Top 5%).
*   **Thermals:** Stable **~37°C** under mixed load.
*   **Knox Integrity:** **100% Safe** (No root, no bootloader unlocking).

---

## 💡 The Philosophy
The conventional approach to "debloating" (manually running randomADB commands) is obsolete. It lacks consistency and is impossible to maintain. **The Ruvomain Protocol** shifts this paradigm by treating system optimization as an **industrialized engineering process**.

We don't "trick" the system; we curate it. By surgically removing non-essential services while maintaining framework stability, we ensure the device performs at its peak potential.

---

## 📦 Protocol Hierarchy
The protocol is modular, allowing users to choose their level of optimization:

| Tier | Strategy| Recommended For |
|:---|:---|:---|
| **Tier 1 (Safe)** | Redundancy & Telemetry | All users seeking immediate gains. |
| **Tier 2 (Balanced)** | AI Telemetry & Cloud Bloat | Users prioritizing privacy & efficiency. |
| **Tier 3 (Surgical)** | Ghost Mode (System Core) | Advanced users building a bare-metal experience. |
| **Extreme** | Combined "Total War" | Power-users (Full audit highly recommended). |

*See `/presets` for configuration files.*

---

## ⚙️ Quick Start
1.  **Environment:** Install [Shizuku](https://shizuku.rikka.app/) and[Canta](https://samolego.github.io/Canta/).
2.  **Activate:** Enable Developer Options > Wireless Debugging. Pair Shizuku.
3.  **Deploy:** Import the preferred `.json` file from the `/presets` folder into Canta.
4.  **Finalize:** Reboot the device.

---

## 🛡️ Safety & Auditing
Transparency is a core pillar.
*   **Critical Safeguards:** Do **not** disable packages like `com.sec.location.nsflp2` (GPS) or `com.samsung.android.smartmirroring` (Smart View).
*   **Auditing:** Every package included in our tiers is verified for stability. Users are encouraged to inspect the lists in `/docs/package-list.md`.

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

---
### 📸 Proof of Concept
<img src="assets/accu-93.jpg" width="400"> <img src="assets/thermalg-cputemp.jpg" width="400"> <img src="assets/thermalg-cpu.jpg" width="400"> <img src="assets/thermalg-temp.jpg" width="400"> <img src="assets/antutu-score.jpg" width="400"> <img src="assets/antutu-ranking.jpg" width="400"> 

## ⚠️ Disclaimer
*I am not responsible for any issues resulting from system modifications. Always perform a data backup before deployment.*

**Stay clean, stayfast, stay Ruvomain.** 🚀
