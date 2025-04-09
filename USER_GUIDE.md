# Security Hardening User Guide

Welcome to the Security Hardening Script! This guide will help you safely enhance your device's security using our automated hardening tool.

## 🚨 Important Safety Information

Before proceeding, please read these important safety notes:

1. **Backup Your Data**: Always create a backup of your important files before running any security hardening tool.
2. **Test First**: If possible, test the script on a non-production system first.
3. **Choose Wisely**: Select the security tier that best matches your needs and technical expertise.
4. **Be Patient**: Some security changes may take time to apply and may require system restarts.

## 📋 Quick Start Guide

### Step 1: Choose Your Security Level

The script offers three security levels:

1. **Standard Security** (Recommended for most users)
   - Essential security measures
   - Minimal impact on usability
   - Good for everyday users

2. **Advanced Security** (Recommended for advanced users)
   - Enhanced security features
   - Moderate impact on usability
   - Good for users who need stronger security

3. **Strict Security** (For security professionals)
   - Maximum security measures
   - Significant impact on usability
   - Only for users who understand the implications

### Step 2: Installation

#### For Windows Users:
1. Download the Windows installer
2. Right-click the installer and select "Run as Administrator"
3. Follow the on-screen instructions
4. Choose your security tier when prompted

#### For macOS Users:
1. Open Terminal
2. Copy and paste this command:
   ```bash
   curl -L https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/install.sh | bash
   ```
3. Enter your administrator password when prompted
4. Choose your security tier when prompted

#### For Linux Users:
1. Open Terminal
2. Copy and paste this command:
   ```bash
   curl -L https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/install.sh | bash
   ```
3. Enter your root password when prompted
4. Choose your security tier when prompted

## 🔒 What the Script Does

The security hardening script will:

1. **Enhance Password Security**
   - Set stronger password requirements
   - Configure password history
   - Set account lockout policies

2. **Improve Firewall Protection**
   - Enable system firewall
   - Block vulnerable ports
   - Allow only necessary connections

3. **Disable Risky Services**
   - Turn off unnecessary network services
   - Disable potentially dangerous features
   - Configure secure service settings

4. **Additional Security Features**
   - Enable encryption (where available)
   - Configure secure boot options
   - Set up additional security measures

## ⚠️ Important Notes

1. **System Requirements**
   - Windows: Windows 10 or later
   - macOS: macOS 10.13 or later
   - Linux: Most modern distributions

2. **Prerequisites**
   - Administrative/root access
   - Internet connection for installation
   - Python 3.6 or later

3. **Potential Impacts**
   - Some applications might need reconfiguration
   - Network services might be affected
   - System performance might be slightly impacted

## 🔄 Reverting Changes

If you need to undo the security changes:

1. **Windows**:
   - Run `C:\Program Files\Security Hardening\uninstall.ps1` as Administrator

2. **macOS/Linux**:
   - Run `/opt/security_hardening/uninstall.sh` with sudo

## 📝 After Installation

1. **Review the Report**
   - Check the generated security report
   - Review the changes made to your system
   - Note any important warnings or recommendations

2. **Test Your System**
   - Verify that essential applications work
   - Check network connectivity
   - Test any critical services

3. **Regular Maintenance**
   - Run the script periodically to maintain security
   - Update your system regularly
   - Keep your security settings current

## ❓ Common Questions

**Q: Will this break my computer?**
A: The script is designed to be safe, but always backup your data first.

**Q: Can I change security tiers later?**
A: Yes, you can run the script again with a different tier.

**Q: What if something goes wrong?**
A: Use the uninstall script to revert changes, then contact support.

**Q: How often should I run this?**
A: Run it once for initial setup, then periodically for maintenance.

## 📞 Support

If you encounter any issues:
1. Check the generated log file
2. Review the security report
3. Contact support with your system details

## ⚖️ Disclaimer

This script is provided as-is without warranty. Use at your own risk. Always test in a non-production environment first.

---

Thank you for using our Security Hardening Script! Stay safe online! 🔒 