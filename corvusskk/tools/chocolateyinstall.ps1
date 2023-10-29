$packageName = 'CorvusSKK'
$installerType = 'exe'
$url = 'https://github.com/nathancorvussolis/corvusskk/releases/download/3.2.2/corvusskk-3.2.2.exe'
$checksum = 'cdc17a6ce3febed346ecfd3f5cec0aef39c4302518a209383c4377ea7ed90110'
$checksumType = 'sha256'
$silentArgs = '/quiet /norestart'
$validExitCodes= @(0, 3010)

$osVersion = [version](Get-WmiObject Win32_OperatingSystem).Version

if($osVersion -eq [version]"6.1.7600") {
  Write-Warning "$packageName requires Service Pack 1 on Windows 7 / Server 2008 R2."
  return
}

if($osVersion -eq [version]"6.3.9600") {
  $hotfix = Get-HotFix | where hotfixID -eq KB2919355
  if($hotfix -eq $null) {
    Write-Warning "$packageName requires KB2919355 on Windows 8.1 / Server 2012 R2."
    return
  }
}

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -Url "$url" `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -SilentArgs "$silentArgs" `
                          -ValidExitCodes $validExitCodes

Write-Warning "$packageName requires to restart Windows for complete installation."
