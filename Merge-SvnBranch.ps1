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

		[switch]
		$RecordOnly = $false
	)

	$ErrorActionPreference = 'Stop'

	$config = Get-Configuration
	$SourceRoot = $config.GetValue('Root', $null, $SourceRoot)
	$SourceBranches = $config.GetValue('Branches', $null, $SourceBranches)
	$SourcePostfix = $config.GetValue('Postfix', $null, $SourcePostfix)
	$TargetRoot = $config.GetValue('Root', $SourceRoot, $TargetRoot)
	$TargetBranches = $config.GetValue('Branches', $SourceBranches, $TargetBranches)
	$TargetPostfix = $config.GetValue('Postfix', $SourcePostfix, $TargetPostfix)
	$svn = $config.GetValue('svn', 'svn')

	$sourceUrl = $config.ResolveSvnPath($SourceRoot, $SourceBranches, $SourcePostfix, $SourceName)

	Switch-SvnBranch `
	  -Root $TargetRoot `
	  -Branches $TargetBranches `
	  -Postfix $TargetPostfix `
	  $TargetName

	if ($RecordOnly) {
		$option = '--record-only'
	} else {
		$option = ''
	}

	Write-Message "Merging branch $sourceUrl"
	& $svn merge $option $sourceUrl
}