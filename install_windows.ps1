# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Please run this script as Administrator" -ForegroundColor Red
    exit 1
}

Write-Host "Security Hardening Installation Script" -ForegroundColor Green
Write-Host "========================================="

# Check for required dependencies
Write-Host "Checking dependencies..." -ForegroundColor Yellow
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Python is required but not installed." -ForegroundColor Red
    Write-Host "Please install Python from https://www.python.org/downloads/"
    exit 1
}

# Select security tier
Write-Host "`nSelect security tier:" -ForegroundColor Yellow
Write-Host "1) Standard - Essential security with minimal impact"
Write-Host "2) Advanced - Enhanced security with moderate impact"
Write-Host "3) Strict - Maximum security with potential usability impact"
$tierChoice = Read-Host "Enter your choice (1-3)"

switch ($tierChoice) {
    "1" { $tier = "standard" }
    "2" { $tier = "advanced" }
    "3" { $tier = "strict" }
    default { 
        Write-Host "Invalid choice. Defaulting to Standard tier." -ForegroundColor Red
        $tier = "standard"
    }
}

# Create installation directory
$installDir = "C:\Program Files\Security Hardening"
New-Item -ItemType Directory -Force -Path $installDir | Out-Null

# Download required files
Write-Host "`nDownloading security hardening files..." -ForegroundColor Yellow
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile("https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/security_hardener.py", "$installDir\security_hardener.py")
$webClient.DownloadFile("https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/config_${tier}.json", "$installDir\config_${tier}.json")
$webClient.DownloadFile("https://raw.githubusercontent.com/MMGehrke/Automated-Security-Hardening/main/requirements.txt", "$installDir\requirements.txt")

# Install Python dependencies
Write-Host "`nInstalling Python dependencies..." -ForegroundColor Yellow
pip install -r "$installDir\requirements.txt"

# Create uninstall script
$uninstallScript = @"
# Check if running as administrator
`$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not `$isAdmin) {
    Write-Host "Please run this script as Administrator" -ForegroundColor Red
    exit 1
}

`$installDir = "C:\Program Files\Security Hardening"
Remove-Item -Path `$installDir -Recurse -Force
Write-Host "Security hardening tools have been uninstalled."
"@

$uninstallScript | Out-File -FilePath "$installDir\uninstall.ps1" -Encoding UTF8

# Run the security hardening script
Write-Host "`nRunning security hardening script..." -ForegroundColor Yellow
python "$installDir\security_hardener.py" $tier

Write-Host "`nInstallation complete!" -ForegroundColor Green
Write-Host "Security hardening script has been installed to $installDir"
Write-Host "To run the script again, use: python $installDir\security_hardener.py $tier"
Write-Host "To uninstall, run: $installDir\uninstall.ps1"
Write-Host "`nPlease review the generated security report for details of the changes made." -ForegroundColor Yellow 