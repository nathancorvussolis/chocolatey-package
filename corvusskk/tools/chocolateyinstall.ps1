$packageName = 'CorvusSKK'
$installerType = 'exe'
$url = 'https://github.com/nathancorvussolis/corvusskk/releases/download/3.3.3/corvusskk-3.3.3.exe'
$checksum = '5F7E277DF4993364704F8737A8A19C41637357BAC825FADEB93BEE81EA638074'
$checksumType = 'sha256'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$validExitCodes = @(0)

$osVersion = [version](Get-WmiObject Win32_OperatingSystem).Version

if ($osVersion -lt [version]"10.0.14393") {
  Write-Warning "$packageName supports Windows 10 version 1607 build 14393 or later."
  return
}

Install-ChocolateyPackage `
  -PackageName "$packageName" `
  -FileType "$installerType" `
  -Url "$url" `
  -Checksum "$checksum" `
  -ChecksumType "$checksumType" `
  -SilentArgs "$silentArgs" `
  -ValidExitCodes $validExitCodes

Write-Warning "$packageName requires to restart Windows for complete installation."
