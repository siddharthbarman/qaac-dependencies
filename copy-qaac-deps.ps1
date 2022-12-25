# ------------------------------------------------------------------------------------------------
# Author      : Siddharth B
# Date        : 25-DEC-2022
# Description : Copyies Apple dlls from iTunes folder needed by QAAC to work.
# Syntax      : copy-qaac-deps.ps1 <QAAC-FOLDER>
# ------------------------------------------------------------------------------------------------
param(
    [Parameter(Mandatory)]
    [String]$directory
)

if (-not (Test-Path $directory)) 
{
    Write-Host "The specified directory does not exist or you do not have permission to read it."
    exit 1
}


$matches = Get-ChildItem -Path "C:\Program Files\WindowsApps\Apple*"
$iTunesDirectory = ""

foreach ($folder in $matches)
{
    $iTunesExe = $folder.FullName + "\iTunes.exe"
    if (Test-Path $iTunesExe) 
    {        
        $iTunesDirectory = $folder.FullName    
    }
    
}

if ($iTunesDirectory -eq "")
{
    Write-Host "Could not find iTunes on the system."
    exit 1
}

Write-Host "iTunes.exe found at: " + $iTunesDirectory
$fileNames = $data = @("ASL.dll", "CoreAudioToolbox.dll", "CoreFoundation.dll", "icudt62.dll", "libdispatch.dll", "libicuin.dll", "libicuuc.dll", "objc.dll")

Write-Host "Copying files..."
foreach ($fileName in $fileNames)
{
    $source = Join-Path -Path $iTunesDirectory -ChildPath $fileName
    Copy-Item -path $source -destination $directory
    Write-Host $source
}

Write-Host "All files copied successfully"
    


