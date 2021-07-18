#!/snap/bin/pwsh
Set-Location $PSScriptRoot
$ErrorActionPreference = "Error"

# Ensure config file is available
$config = New-Object -TypeName PSObject -Property @{
    RepositoryInformationUrl = ""
    WaitTimeInSeconds = 30
    GithubUsername = ""
    GithubRepository = ""
    ExecuteOnChange = ""
}
$configFilename = "config.json"

if (-not (Test-Path $configFilename)) {
    $config | ConvertTo-Json | Out-File $configFilename

    Write-Host "I could not find a config file, so I created one for you to complete."
    Write-Host "Look for $configFilename in the directory that contains this script."
    exit
} else {
    $config = Get-Content $configFilename | ConvertFrom-Json
}

# Ensure configuration is correct and complete
if ( -not([bool]$config.GithubUsername) ) {
    Write-Host "  - $(Get-Date) Github username is not configured yet. Do your job, so I can do mine."
    exit
}

if ( -not([bool]$config.GithubRepository) ) {
    Write-Host "  - $(Get-Date) Github repository is not configured yet. Do your job, so I can do mine."
    exit
}
if ( -not([bool]$config.RepositoryInformationUrl) ) {
    Write-Host "  - $(Get-Date) RepositoryInformationUrl is not configured yet. Do your job, so I can do mine."
    exit
}

# Start the process
Write-Host "  - $(Get-Date) Auto-Updater started ..."
Write-Host "  - $(Get-Date) Looking for updates for $($config.GithubUsername)/$($config.GithubRepository) ..."

$previousStateFilename = ($config.GithubUsername + "_" + $config.GithubRepository) + ".state"
while ($true) {
    try {
        Write-Host "  - $(Get-Date) testing for changes ..."
        $infoUrl = $config.RepositoryInformationUrl + "?user=" + $config.GithubUsername + "&repository=" + $config.GithubRepository
        $lastPushInfoFromTheWeb = (Invoke-WebRequest $infoUrl).Content
        $previousState = ""
        if ( Test-Path $previousStateFilename ) {
            $previousState = Get-Content $previousStateFilename 
        }

        if ($lastPushInfoFromTheWeb -ne $previousState) {
           Write-Host "  - $(Get-Date) I detected that something has changed"
           &$config.ExecuteOnChange
           $lastPushInfoFromTheWeb | Out-File $previousStateFilename 
        }

        Start-Sleep -Seconds $config.WaitTimeInSeconds 
    }
    catch {
        Write-Host $_
    }
}

