function Merge-Branch {
	[CmdletBinding()]
	param(
		$SourceRoot = '^/Root',
		$SourceBranchesBase = 'branches',
		$SourceBranchesPostfix = 'company',
		[Parameter(Mandatory = $true, Position = 1)]
		$SourceName,

		$TargetRoot = $SourceRoot,
		$TargetBranchesBase = $SourceBranchesBase,
		$TargetBranchesPostfix = $SourceBranchesPostfix,

		[Parameter(Mandatory = $true, Position = 2)]
		$TargetName = 'trunk',

		[switch]
		$RecordOnly = $false
	)

	Switch-Branch -RootUrl $TargetRoot -BranchesBase $TargetBranchesBase -BranchesPostfix $TargetBranchesPostfix $TargetName

	$branchUrl = Resolve-Branch $SourceRoot $SourceBranchesBase $SourceBranchesPostfix $SourceName

	if ($RecordOnly) {
		$option = '--record-only'
	} else {
		$option = ''
	}

	Write-Output "Merging branch $branchUrl"
	svn merge $option $branchUrl
}