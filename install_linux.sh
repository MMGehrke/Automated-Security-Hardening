#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Please run as root${NC}"
    exit 1
fi

echo -e "${GREEN}Security Hardening Installation Script${NC}"
echo "========================================="

# Check for required dependencies
echo -e "${YELLOW}Checking dependencies...${NC}"
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Python3 is required but not installed.${NC}"
    echo "Installing Python3..."
    apt-get update
    apt-get install -y python3 python3-pip
fi

if ! command -v ufw &> /dev/null; then
    echo -e "${RED}UFW is required but not installed.${NC}"
    echo "Installing UFW..."
    apt-get update
    apt-get install -y ufw
fi

# Select security tier
echo -e "\n${YELLOW}Select security tier:${NC}"
echo "1) Standard - Essential security with minimal impact"
echo "2) Advanced - Enhanced security with moderate impact"
echo "3) Strict - Maximum security with potential usability impact"
read -p "Enter your choice (1-3): " tier_choice

case $tier_choice in
    1) tier="standard";;
    2) tier="advanced";;
    3) tier="strict";;
    *) echo -e "${RED}Invalid choice. Defaulting to Standard tier.${NC}"; tier="standard";;
esac

# Create installation directory
INSTALL_DIR="/opt/security_hardening"
mkdir -p $INSTALL_DIR

# Download required files
echo -e "\n${YELLOW}Downloading security hardening files...${NC}"
curl -L -o $INSTALL_DIR/security_hardener.py https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/security_hardener.py
curl -L -o $INSTALL_DIR/config_${tier}.json https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/config_${tier}.json
curl -L -o $INSTALL_DIR/requirements.txt https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/requirements.txt

# Install Python dependencies
echo -e "\n${YELLOW}Installing Python dependencies...${NC}"
pip3 install -r $INSTALL_DIR/requirements.txt

# Make script executable
chmod +x $INSTALL_DIR/security_hardener.py

# Create symbolic link
ln -sf $INSTALL_DIR/security_hardener.py /usr/local/bin/security_hardener

# Run the security hardening script
echo -e "\n${YELLOW}Running security hardening script...${NC}"
python3 $INSTALL_DIR/security_hardener.py $tier

# Create uninstall script
cat > $INSTALL_DIR/uninstall.sh << 'EOF'
#!/bin/bash
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root"
    exit 1
fi

INSTALL_DIR="/opt/security_hardening"
rm -rf $INSTALL_DIR
rm -f /usr/local/bin/security_hardener
echo "Security hardening tools have been uninstalled."
EOF

chmod +x $INSTALL_DIR/uninstall.sh

echo -e "\n${GREEN}Installation complete!${NC}"
echo -e "Security hardening script has been installed to ${INSTALL_DIR}"
echo -e "To run the script again, use: security_hardener ${tier}"
echo -e "To uninstall, run: ${INSTALL_DIR}/uninstall.sh"
echo -e "\n${YELLOW}Please review the generated security report for details of the changes made.${NC}" 