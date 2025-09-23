$packageName = 'CorvusSKK'
$installerType = 'exe'
$url = 'https://github.com/nathancorvussolis/corvusskk/releases/download/3.3.1/corvusskk-3.3.1.exe'
$checksum = 'e67827b92d633eaf0cfd85d7735da0488a04630cfb918f05bd71e48d084a8fa6'
$checksumType = 'sha256'
$silentArgs = '/quiet /norestart'
$validExitCodes= @(0, 3010)

$osVersion = [version](Get-WmiObject Win32_OperatingSystem).Version

if($osVersion -lt [version]"10.0.14393") {
  Write-Warning "$packageName supports Windows 10 version 1607 build 14393 or later."
  return
}

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -Url "$url" `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -SilentArgs "$silentArgs" `
                          -ValidExitCodes $validExitCodes

Write-Warning "$packageName requires to restart Windows for complete installation."
