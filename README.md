# Automated Security Hardening Script

This script automatically applies security hardening configurations to Linux, Windows, and macOS systems. It helps reduce the attack surface and improve the overall security posture of the system.

## Quick Installation

### One-Line Installation
Copy and paste the following command into your terminal:

```bash
curl -L https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/install.sh | bash
```

### Manual Installation
1. Download the appropriate installer for your OS:
   - [Linux Installer](https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/install_linux.sh)
   - [macOS Installer](https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/install_macos.sh)
   - [Windows Installer](https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/install_windows.ps1)

2. Make the script executable (Linux/macOS only):
   ```bash
   chmod +x install_*.sh
   ```

3. Run the installer with administrative privileges:
   - Linux/macOS: `sudo ./install_*.sh`
   - Windows: Right-click the PowerShell script and select "Run as Administrator"

## Security Tiers

The script offers three levels of security hardening:

### Standard Tier
- Focuses on fundamental, low-impact security measures
- Minimal impact on usability
- Recommended for most systems
- Includes:
  - Basic service management
  - Simple password policies
  - Essential firewall rules
  - Core macOS security features

### Advanced Tier
- Includes all Standard tier measures
- Adds more proactive and restrictive configurations
- Balanced security and usability
- Includes:
  - Enhanced service management
  - Stronger password policies
  - Comprehensive firewall rules
  - Additional macOS security features

### Strict Tier
- Includes all Advanced tier measures
- Implements the most aggressive hardening measures
- Maximum security with potential usability impact
- Includes:
  - Extensive service management
  - Strict password policies
  - Restrictive firewall rules
  - Advanced macOS security features
  - Additional security restrictions

## Features

- Service Management
  - Disables unnecessary services
  - Configures service startup types
  - Supports Linux, Windows, and macOS systems

- Password Policies
  - Enforces strong password complexity
  - Configures password history
  - Sets account lockout policies
  - Implements password expiration

- Firewall Configuration
  - Enables and configures system firewall
  - Blocks common vulnerable ports
  - Allows only necessary connections
  - Supports UFW (Linux), Windows Firewall, and macOS Application Firewall

- macOS-Specific Features
  - FileVault encryption
  - Gatekeeper application security
  - System Integrity Protection (SIP)
  - Additional security features in strict tier

## Requirements

- Python 3.6 or higher
- Administrative/root privileges
- For Linux: UFW (Uncomplicated Firewall) installed
- For Windows: PowerShell 5.0 or higher
- For macOS: macOS 10.13 or higher

## Usage

After installation, you can run the security hardening script with your chosen tier:

```bash
# Standard tier
security_hardener standard

# Advanced tier
security_hardener advanced

# Strict tier
security_hardener strict
```

## Uninstallation

To uninstall the security hardening tools:

- Linux/macOS: Run `/opt/security_hardening/uninstall.sh`
- Windows: Run `C:\Program Files\Security Hardening\uninstall.ps1`

## Configuration

Each tier has its own configuration file:
- `config_standard.json` - Standard security settings
- `config_advanced.json` - Advanced security settings
- `config_strict.json` - Strict security settings

You can modify these files to:
- Specify which services to disable
- Configure password policies
- Define firewall rules
- Customize other security settings

## Security Considerations

1. **Backup**: Always backup your system before running the script
2. **Testing**: Test the script in a non-production environment first
3. **Tier Selection**: Choose the appropriate tier based on your security needs
4. **Customization**: Review and customize the configuration files
5. **Privileges**: Run the script with appropriate administrative privileges

## Logging and Reporting

The script generates:
- Detailed logs in `security_hardening.log`
- A JSON report file with timestamp and tier information
- Console output of all actions

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Disclaimer

This script is provided as-is without any warranty. Use it at your own risk. Always test in a non-production environment first. 