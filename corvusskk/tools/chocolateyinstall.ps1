$packageName = 'CorvusSKK'
$installerType = 'exe'
$url = 'https://github.com/nathancorvussolis/corvusskk/releases/download/2.7.5/corvusskk-2.7.5.exe'
$checksum = 'E0CFF0D8D3C8C27300E0FA32026685DE836A816B7135E93084BE65751F2EE769'
$checksumType = 'sha256'
$silentArgs = '/quiet /norestart'
$validExitCodes= @(0, 3010)

$osVersion = [version](Get-WmiObject Win32_OperatingSystem).Version

if(($osVersion -eq [version]"6.0.6000") -or ($osVersion -eq [version]"6.0.6001")) {
  Write-Warning "$packageName requires Service Pack 2 on Windows Vista / Server 2008."
  return
}

if($osVersion -eq [version]"6.0.6002") {
  $hotfix971512 = Get-HotFix | where hotfixID -eq KB971512
  $hotfix971644 = Get-HotFix | where hotfixID -eq KB971644
  if(($hotfix971512 -eq $null) -and ($hotfix971644 -eq $null)) {
    Write-Warning "$packageName requires KB971512 or KB971644 on Windows Vista / Server 2008."
    return
  }
}

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
