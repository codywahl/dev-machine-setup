#Requires -RunAsAdministrator
$choclatelyInstalled = $false
$appConfigFile = [IO.Path]::Combine($currentDirectory, '.\dev-apps.config')

try {
    choco config get cacheLocation
    $choclatelyInstalled = $true
}
catch {
    $choclatelyInstalled = $false
}

if ($choclatelyInstalled) {
    Write-Host "Chocolately detected." -BackgroundColor "Green" -ForegroundColor "White"
}
else {
    Write-Output "Chocolatey not detected."
}


function DisplayHelp {
    "This is the help menu."
}

function InstallChocolately {
    if ($choclatelyInstalled) {
        Write-Host "Chocolately installation already detected." -BackgroundColor "Yellow" -ForegroundColor "Black"
    }
    else {
        Write-Host "Installing Chocolately." -BackgroundColor "Yellow" -ForegroundColor "Black"
        #iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
}

function DisplayAllDevApps {
    [xml]$xml = Get-Content $appConfigFile
    $xml.packages.package | ft    
}

function InstallDevApps {
    if ($env:ChocolateyInstall) {
        choco install $appConfigFile
    }
    else {
        Write-Host "Chocolatey not detected. Run Chocolately install first."
    }
    
}

function UpdateApps {
    if ($env:ChocolateyInstall) {
        choco upgrade all
    }
    else {
        Write-Host "Chocolatey not detected. Run Chocolately install first."
    }
}

function ListPackages {
    choco list --local-only
}

function Show-Menu {
    Clear-Host
    Write-Host "================ Machine setup: options ================"
    
    Write-Host "1: Press '1' for help."
    Write-Host "2: Press '2' to install Chocolately."
    Write-Host "3: Press '3' to display all 'Dev Apps'."
    Write-Host "4: Press '4' to install all 'Dev Apps'."
    Write-Host "5: Press '5' to upgrade all Chocolately installed apps."
    Write-Host "6: Press '6' to list locally installed packages."
    Write-Host "Q: Press 'Q' to quit."
}

do {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection) {
        '1' {
            Write-Host ""
            DisplayHelp
            Write-Host ""
        } 
        '2' {
            Write-Host ""
            InstallChocolately
            Write-Host ""
        } 
        '3' {
            Write-Host ""
            DisplayAllDevApps
            Write-Host ""
        }
        '4' {
            Write-Host ""
            InstallDevApps
            Write-Host ""
        }
        '5' {
            Write-Host ""
            UpdateApps
            Write-Host ""
        }
        '6' {
            Write-Host ""
            ListPackages
            Write-Host ""
        }
        # '7'{
        #     Write-Host ""
            
        #     Write-Host ""
        # }
        # '8'{
        #     Write-Host ""
            
        #     Write-Host ""
        # }
    }
    pause
}

until ($selection -eq 'q')