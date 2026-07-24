The core of **Ruvomain-PBD** is `json-walk`, an event-driven (SAX-style) parser written in pure Bash. It processes your configurations natively, ensuring compatibility across Linux, Termux, and Android without requiring external binaries like `jq`.

## Why JSON-Parsing & Pure Bash guarantee privacy

*   **Auditability:** Unlike pre-compiled binaries, Ruvomain is 100% human-readable. You know exactly what happens to your device.
*   **Independence:** No runtime middleman. No background services. No "Shizuku" constant communication.
*   **Integrity:** Data (JSON lists) is strictly separated from logic (Bash). The lists contain only metadata, not hidden executables, ensuring zero telemetry or backdoors.
*   **Offline-First:** The protocol runs without any network dependency, ensuring your system state remains truly yours.
