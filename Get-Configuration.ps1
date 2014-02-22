function Get-Configuration {
	$configFileName = 'SvnUtils.config'

	$directory = Get-Item .
	while ($directory -ne $null -and -not (Test-Path "$($directory.FullName)\$configFileName")) {
		$directory = $directory.Parent
	}

	if ($directory -eq $null) {
		throw "Cannot find $configFileName"
	}

	$path = "$($directory.FullName)\$configFileName"

	Write-Host "Found configuration file at $path"

	$config = Invoke-Expression ([IO.File]::ReadAllText($path))
    $config | Add-Member -MemberType ScriptMethod -Name 'GetValue' -Value {
		param (
			$Name,
			$DefaultValue,
			$Substitute
		)

		if ($Substitute -ne $null) {
			$Substitute
		} else {
			$value = $this[$Name]
			if ($value -eq $null) {
				$DefaultValue
			} else {
				$value
			}
		}
	}

	$config
}