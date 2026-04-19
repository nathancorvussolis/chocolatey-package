$packageName = 'CorvusSKK'
$installerType = 'exe'
$url = 'https://github.com/nathancorvussolis/corvusskk/releases/download/3.3.2/corvusskk-3.3.2.exe'
$checksum = 'c2374f934bca2266d38fc7c91dfd3af275b4f8893bd5a04e3b0db1b9d1dbf6ed'
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
