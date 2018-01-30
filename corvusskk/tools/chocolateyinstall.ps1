$packageName = 'CorvusSKK'
$installerType = 'exe'
$url = 'https://github.com/nathancorvussolis/corvusskk/releases/download/2.5.9/corvusskk-2.5.9.exe'
$checksum = '35BF5DA90FF722AFDDB44D338EBF8BB5CE563820BB4E056F152D21D2DBB0D1AA'
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
