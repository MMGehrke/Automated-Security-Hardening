#!/usr/bin/env python3

import os
import sys
import platform
import logging
import json
from datetime import datetime
import subprocess
from typing import Dict, List, Optional

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('security_hardening.log'),
        logging.StreamHandler()
    ]
)

class SecurityHardener:
    def __init__(self, config_file: str = 'config.json'):
        self.os_type = platform.system().lower()
        self.config = self._load_config(config_file)
        self.report = {
            'timestamp': datetime.now().isoformat(),
            'os_type': self.os_type,
            'changes': []
        }

    def _load_config(self, config_file: str) -> Dict:
        """Load configuration from JSON file"""
        try:
            with open(config_file, 'r') as f:
                return json.load(f)
        except FileNotFoundError:
            logging.error(f"Configuration file {config_file} not found")
            sys.exit(1)
        except json.JSONDecodeError:
            logging.error(f"Invalid JSON in configuration file {config_file}")
            sys.exit(1)

    def _execute_command(self, command: List[str]) -> bool:
        """Execute a system command and return success status"""
        try:
            result = subprocess.run(command, capture_output=True, text=True)
            if result.returncode == 0:
                return True
            logging.error(f"Command failed: {command}\nError: {result.stderr}")
            return False
        except Exception as e:
            logging.error(f"Error executing command {command}: {str(e)}")
            return False

    def manage_services(self) -> None:
        """Manage system services based on configuration"""
        if self.os_type == 'linux':
            self._manage_linux_services()
        elif self.os_type == 'windows':
            self._manage_windows_services()

    def _manage_linux_services(self) -> None:
        """Manage Linux services"""
        for service in self.config.get('services', []):
            if service.get('disable', False):
                if self._execute_command(['systemctl', 'disable', service['name']]):
                    self.report['changes'].append({
                        'type': 'service',
                        'action': 'disabled',
                        'service': service['name']
                    })
                    logging.info(f"Disabled service: {service['name']}")

    def _manage_windows_services(self) -> None:
        """Manage Windows services"""
        for service in self.config.get('services', []):
            if service.get('disable', False):
                if self._execute_command(['powershell', '-Command', f'Set-Service -Name "{service["name"]}" -StartupType Disabled']):
                    self.report['changes'].append({
                        'type': 'service',
                        'action': 'disabled',
                        'service': service['name']
                    })
                    logging.info(f"Disabled service: {service['name']}")

    def configure_password_policies(self) -> None:
        """Configure password policies based on configuration"""
        if self.os_type == 'linux':
            self._configure_linux_password_policies()
        elif self.os_type == 'windows':
            self._configure_windows_password_policies()

    def _configure_linux_password_policies(self) -> None:
        """Configure Linux password policies"""
        policies = self.config.get('password_policies', {})
        
        # Configure password complexity
        if policies.get('complexity'):
            pam_config = f"password requisite pam_pwquality.so retry=3 minlen={policies['complexity']['min_length']} "
            pam_config += f"dcredit={policies['complexity']['min_digits']} "
            pam_config += f"ucredit={policies['complexity']['min_uppercase']} "
            pam_config += f"lcredit={policies['complexity']['min_lowercase']} "
            pam_config += f"ocredit={policies['complexity']['min_special']}"
            
            with open('/etc/security/pwquality.conf', 'w') as f:
                f.write(pam_config)
            
            self.report['changes'].append({
                'type': 'password_policy',
                'action': 'configured',
                'policy': 'complexity'
            })

    def _configure_windows_password_policies(self) -> None:
        """Configure Windows password policies"""
        policies = self.config.get('password_policies', {})
        
        if policies.get('complexity'):
            commands = [
                ['net', 'accounts', f'/minpwlen:{policies["complexity"]["min_length"]}'],
                ['net', 'accounts', '/maxpwage:90'],
                ['net', 'accounts', '/minpwage:1'],
                ['net', 'accounts', f'/uniquepw:{policies["complexity"]["history"]}']
            ]
            
            for cmd in commands:
                if self._execute_command(cmd):
                    self.report['changes'].append({
                        'type': 'password_policy',
                        'action': 'configured',
                        'policy': cmd[1]
                    })

    def configure_firewall(self) -> None:
        """Configure firewall based on configuration"""
        if self.os_type == 'linux':
            self._configure_linux_firewall()
        elif self.os_type == 'windows':
            self._configure_windows_firewall()

    def _configure_linux_firewall(self) -> None:
        """Configure Linux firewall using ufw"""
        if not self._execute_command(['which', 'ufw']):
            logging.error("UFW is not installed. Please install it first.")
            return

        # Reset firewall
        self._execute_command(['ufw', '--force', 'reset'])
        
        # Set default policies
        self._execute_command(['ufw', 'default', 'deny', 'incoming'])
        self._execute_command(['ufw', 'default', 'allow', 'outgoing'])
        
        # Configure rules from config
        for rule in self.config.get('firewall_rules', []):
            cmd = ['ufw']
            if rule.get('allow'):
                cmd.append('allow')
            else:
                cmd.append('deny')
            
            if rule.get('port'):
                cmd.append(f"{rule['port']}/{rule.get('protocol', 'tcp')}")
            
            if self._execute_command(cmd):
                self.report['changes'].append({
                    'type': 'firewall',
                    'action': 'rule_added',
                    'rule': rule
                })
        
        # Enable firewall
        if self._execute_command(['ufw', '--force', 'enable']):
            self.report['changes'].append({
                'type': 'firewall',
                'action': 'enabled'
            })

    def _configure_windows_firewall(self) -> None:
        """Configure Windows firewall"""
        # Enable firewall for all profiles
        profiles = ['Domain', 'Private', 'Public']
        for profile in profiles:
            if self._execute_command(['netsh', 'advfirewall', 'set', profile, 'state', 'on']):
                self.report['changes'].append({
                    'type': 'firewall',
                    'action': 'enabled',
                    'profile': profile
                })
        
        # Configure rules from config
        for rule in self.config.get('firewall_rules', []):
            cmd = ['netsh', 'advfirewall', 'firewall', 'add', 'rule']
            cmd.extend([
                f'name="{rule["name"]}"',
                f'dir={rule.get("direction", "in")}',
                f'action={rule.get("action", "block")}',
                f'protocol={rule.get("protocol", "TCP")}'
            ])
            
            if rule.get('port'):
                cmd.append(f'localport={rule["port"]}')
            
            if self._execute_command(cmd):
                self.report['changes'].append({
                    'type': 'firewall',
                    'action': 'rule_added',
                    'rule': rule
                })

    def generate_report(self) -> None:
        """Generate a report of all changes made"""
        report_file = f'security_hardening_report_{datetime.now().strftime("%Y%m%d_%H%M%S")}.json'
        with open(report_file, 'w') as f:
            json.dump(self.report, f, indent=2)
        logging.info(f"Report generated: {report_file}")

def main():
    if len(sys.argv) > 1:
        config_file = sys.argv[1]
    else:
        config_file = 'config.json'

    hardener = SecurityHardener(config_file)
    
    logging.info("Starting security hardening process...")
    
    hardener.manage_services()
    hardener.configure_password_policies()
    hardener.configure_firewall()
    
    hardener.generate_report()
    logging.info("Security hardening process completed.")

if __name__ == "__main__":
    main() 