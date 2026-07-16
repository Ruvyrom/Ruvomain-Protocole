# Ruvomain-Protocole - Main Makefile

# Script paths
ADB_SCRIPT := ./ADB-Termux/devices/S24+/ruvomain.sh
AUTO_SCRIPT := ./Automated/Devices/S24+/ruvomain-automated.sh

.PHONY: help audit run-adb run-auto

help:
  @echo "Ruvomain Protocol Interface"
  @echo "---------------------------"
  @echo "  make audit    - Run shellcheck on all scripts (Static Analysis)"
  @echo "  make run-adb  - Execute the manual script (ADB-Termux)"
  @echo "  make run-auto - Execute the automated script"

audit:
  @echo "Auditing scripts..."
  shellcheck $(ADB_SCRIPT) $(AUTO_SCRIPT)

run-adb:
  @echo "Running ADB-Termux mode..."
  @bash $(ADB_SCRIPT)

run-auto:
  @echo "Running Automated mode..."
  @bash $(AUTO_SCRIPT)
