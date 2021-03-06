﻿function Create-SvnBranch {
	[CmdletBinding()]
	param (
		$SourceRoot,
		$SourceBranches,
		$SourcePostfix,

		[Parameter(Mandatory = $true, Position = 1)]
		$SourceName = 'trunk',

		$TargetRoot,
		$TargetBranches,
		$TargetPostfix,

		[Parameter(Mandatory = $true, Position = 2)]
		$TargetName
	)

	$ErrorActionPreference = 'Stop'

	$config = Get-Configuration
	$SourceRoot = $config.GetValue('Root', $null, $SourceRoot)
	$SourceBranches = $config.GetValue('Branches', $null, $SourceBranches)
	$SourcePostfix = $config.GetValue('Postfix', $null, $SourcePostfix)
	$TargetRoot = $config.GetValueWithPriority($SourceRoot, $TargetRoot)
	$TargetBranches = $config.GetValueWithPriority($SourceBranches, $TargetBranches)
	$TargetPostfix = $config.GetValueWithPriority($SourcePostfix, $TargetPostfix)
	$svn = $config.GetValue('svn', 'svn')
	$messageTemplate = $config.GetValue('CreateMessageTemplate', 'Create branch {0}.')

	$baseUrl = $config.ResolveSvnPath($SourceRoot, $SourceBranches, $SourcePostfix, $SourceName)
	$branchUrl = $config.ResolveSvnPath($TargetRoot, $TargetBranches, $TargetPostfix, $TargetName)

	Write-Message "Branching: $baseUrl -> $branchUrl"

	# Check if branch already exists:
	$ErrorActionPreference = 'SilentlyContinue'
	& $svn ls $branchUrl --depth empty 2>&1 | Out-Null
	$exists = $?
	$ErrorActionPreference = 'Stop'

	if (-not $exists) {
		$message = $messageTemplate -f $TargetName
		$filename = [System.IO.Path]::GetTempFileName()
		$message | Out-File $filename -Encoding utf8

		& $svn copy $baseUrl $branchUrl -F $filename --encoding 'UTF-8'

		Remove-Item $filename
	} else {
		Write-Message "Branch already exists"
	}

	& $svn switch $branchUrl
}
