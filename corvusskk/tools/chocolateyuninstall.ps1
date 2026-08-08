$packageName = 'CorvusSKK'
$softwareName = 'CorvusSKK*'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$validExitCodes = @(0)

[array]$key = Get-UninstallRegistryKey -SoftwareName $softwareName

if ($key.Count -eq 1) {
  $key | % {
    Uninstall-ChocolateyPackage `
      -PackageName $packageName `
      -FileType $installerType `
      -SilentArgs "$silentArgs" `
      -ValidExitCodes $validExitCodes `
      -File "$($_.UninstallString)"
  }
  Write-Warning "$packageName requires to restart Windows for complete uninstallation."
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}
