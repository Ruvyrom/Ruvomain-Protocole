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
	@if adb devices | grep -q "device$$"; then bash $(ADB_SCRIPT); else echo "Error: No device found. Please connect your S24+ via ADB"; fi

run-auto:
	@echo "Running Automated mode..."
	@if adb devices | grep -q "device$$"; then bash $(AUTO_SCRIPT); else echo "Error: No device found. Please connect your S24+ via ADB"; fi