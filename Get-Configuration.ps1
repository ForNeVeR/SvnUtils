function Find-Configuration {
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
	$config = [IO.File]::ReadAllText($path)

	Invoke-Expression $config
}