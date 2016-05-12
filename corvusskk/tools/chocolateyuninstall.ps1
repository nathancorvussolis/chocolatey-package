$packageName = 'CorvusSKK'
$installerType = 'exe'
$bundleUpgradeCode = '{F2664253-EAE9-4ED5-AD92-03229BD8F64F}'
$silentArgs = '/uninstall /quiet /norestart'
$validExitCodes = @(0, 3010)

$keys = Get-ItemProperty -Path @('HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
                                 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*') `
                         -ErrorAction SilentlyContinue `
        | Where-Object { $_.BundleUpgradeCode -contains $bundleUpgradeCode }

foreach($key in $keys) {
  $file = $key.BundleCachePath
  Uninstall-ChocolateyPackage -PackageName "$packageName" `
                              -FileType "$installerType" `
                              -SilentArgs "$silentArgs" `
                              -ValidExitCodes $validExitCodes `
                              -File "$file"
  Write-Warning "$packageName requires to restart Windows for complete uninstallation."
  break
}
