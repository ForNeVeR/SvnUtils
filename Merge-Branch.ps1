function Merge-Branch {
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

	$config = Get-Configuration
	$SourceRoot = $config.GetValue('Root', $null, $SourceRoot)
	$SourceBranches = $config.GetValue('Branches', $null, $SourceBranches)
	$SourcePostfix = $config.GetValue('Postfix', $null, $SourcePostfix)
	$TargetRoot = $config.GetValue('Root', $SourceRoot, $TargetRoot)
	$TargetBranches = $config.GetValue('Branches', $SourceBranches, $TargetBranches)
	$TargetPostfix = $config.GetValue('Postfix', $SourcePostfix, $TargetPostfix)
	$svn = $config.GetValue('svn', 'svn')

	Switch-Branch `
	  -Root $TargetRoot `
	  -Branches $TargetBranches `
	  -Postfix $TargetPostfix `
	  $TargetName

	$branchUrl = Resolve-Branch $SourceRoot $SourceBranches $SourcePostfix $SourceName

	if ($RecordOnly) {
		$option = '--record-only'
	} else {
		$option = ''
	}

	Write-Output "Merging branch $branchUrl"
	& $svn merge $option $branchUrl
}