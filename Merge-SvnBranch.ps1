function Merge-SvnBranch {
	[CmdletBinding()]
	param (
		$SourceRoot,
		$SourceBranches,
		$SourcePostfix,

		[Parameter(Mandatory = $true, Position = 1)]
		$SourceName,

		$TargetRoot,
		$TargetBranches,
		$TargetPostfix,

		[Parameter(Mandatory = $true, Position = 2)]
		$TargetName = 'trunk',

		$Revisions,

		[switch]
		$RecordOnly = $false
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

	$sourceUrl = $config.ResolveSvnPath($SourceRoot, $SourceBranches, $SourcePostfix, $SourceName)

	Switch-SvnBranch_Private `
	  $config `
	  -Root $TargetRoot `
	  -Branches $TargetBranches `
	  -Postfix $TargetPostfix `
	  $TargetName

	$arguments = @('merge')
	if ($RecordOnly) {
		$arguments += '--record-only'
	}
	if ($Revisions) {
		$arguments += '-r' + $Revisions
	}
	$arguments += $sourceUrl

	Write-Message "Starting $svn $arguments"
	Start-Process $svn -ArgumentList $arguments -NoNewWindow -Wait
}