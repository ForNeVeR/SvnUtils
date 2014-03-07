function Get-Configuration {
	[CmdletBinding()]
	$ErrorActionPreference = 'Stop'

	$configFileName = 'SvnUtils.config'

	$directory = Get-Item .
	while ($directory -ne $null -and -not (Test-Path "$($directory.FullName)\$configFileName")) {
		$directory = $directory.Parent
	}

	if ($directory -eq $null) {
		throw "Cannot find $configFileName"
	}

	$path = "$($directory.FullName)\$configFileName"

	Write-Message "Found configuration file at $path"

	$config = Invoke-Expression ([IO.File]::ReadAllText($path))
    $config | Add-Member -PassThru -MemberType ScriptMethod -Name 'GetValue' -Value {
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
	} | Add-Member -PassThru -MemberType ScriptMethod -Name 'GetValueWithPriority' -Value {
		param (
			$DefaultValue,
			$PriorityValue
		)

		if ($PriorityValue) {
			$PriorityValue
		} else {
			$DefaultValue
		}
	} | Add-Member -MemberType ScriptMethod -Name 'ResolveSvnPath' -Value {
		param (
			$Root,
			$Branches,
			$Postfix,
			$BranchName
		)

		$urlParts = switch ($BranchName) {
			'current' {
				$config = Get-Configuration
				$svn = $config.GetValue('svn', 'svn')
				$info = Parse-SvnInfo $(& $svn info)
				@($info['URL'])
			}
			'trunk' {
				@($Root, 'trunk')
			}
			default {
				$result = & $this.SvnPathResolver $Root $Branches $Postfix $BranchName
				if ($result) {
					$result
				} else {
					@($Root, $Branches, $Postfix, $BranchName)
				}
			}
		}

		Format-Url $urlParts
	}

	$config
}