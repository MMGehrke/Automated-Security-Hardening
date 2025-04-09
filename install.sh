#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Security Hardening Installation Script${NC}"
echo "========================================="

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo -e "${YELLOW}Detected Linux system${NC}"
    # Download and run Linux installer
    curl -L -o install_linux.sh https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/install_linux.sh
    chmod +x install_linux.sh
    sudo ./install_linux.sh
    rm install_linux.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo -e "${YELLOW}Detected macOS system${NC}"
    # Download and run macOS installer
    curl -L -o install_macos.sh https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/install_macos.sh
    chmod +x install_macos.sh
    sudo ./install_macos.sh
    rm install_macos.sh
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    echo -e "${YELLOW}Detected Windows system${NC}"
    # Download and run Windows installer
    curl -L -o install_windows.ps1 https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/install_windows.ps1
    powershell -ExecutionPolicy Bypass -File install_windows.ps1
    rm install_windows.ps1
else
    echo -e "${RED}Unsupported operating system: $OSTYPE${NC}"
    exit 1
fi 