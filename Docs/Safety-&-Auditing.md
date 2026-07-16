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
