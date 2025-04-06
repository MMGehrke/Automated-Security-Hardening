# Automated Security Hardening Script

This script automatically applies security hardening configurations to both Linux and Windows systems. It helps reduce the attack surface and improve the overall security posture of the system.

## Features

- Service Management
  - Disables unnecessary services
  - Configures service startup types
  - Supports both Linux and Windows systems

- Password Policies
  - Enforces strong password complexity
  - Configures password history
  - Sets account lockout policies
  - Implements password expiration

- Firewall Configuration
  - Enables and configures system firewall
  - Blocks common vulnerable ports
  - Allows only necessary connections
  - Supports both UFW (Linux) and Windows Firewall

## Requirements

- Python 3.6 or higher
- Administrative/root privileges
- For Linux: UFW (Uncomplicated Firewall) installed
- For Windows: PowerShell 5.0 or higher

## Installation

1. Clone this repository:
```bash
git clone <repository-url>
cd security-hardening-script
```

2. Make the script executable (Linux only):
```bash
chmod +x security_hardener.py
```

## Usage

1. Review and modify the `config.json` file according to your needs.

2. Run the script:
```bash
# Using default config.json
python security_hardener.py

# Using custom configuration file
python security_hardener.py custom_config.json
```

3. Check the generated report:
- The script generates a detailed report in JSON format
- Logs are stored in `security_hardening.log`

## Configuration

The `config.json` file contains all the security settings. You can modify it to:

- Specify which services to disable
- Configure password policies
- Define firewall rules
- Customize other security settings

### Example Configuration

```json
{
    "services": [
        {
            "name": "telnet",
            "disable": true
        }
    ],
    "password_policies": {
        "complexity": {
            "min_length": 12,
            "min_digits": 1,
            "min_uppercase": 1,
            "min_lowercase": 1,
            "min_special": 1,
            "history": 5
        }
    },
    "firewall_rules": [
        {
            "name": "Allow SSH",
            "direction": "in",
            "action": "allow",
            "port": "22",
            "protocol": "TCP"
        }
    ]
}
```

## Security Considerations

1. **Backup**: Always backup your system before running the script
2. **Testing**: Test the script in a non-production environment first
3. **Customization**: Review and customize the configuration file
4. **Privileges**: Run the script with appropriate administrative privileges

## Logging and Reporting

The script generates:
- Detailed logs in `security_hardening.log`
- A JSON report file with timestamp
- Console output of all actions

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Disclaimer

This script is provided as-is without any warranty. Use it at your own risk. Always test in a non-production environment first. 