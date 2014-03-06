function Switch-SvnBranch_Private {
	[CmdletBinding()]
	param (
		[Parameter(Position = 1)]
		$Config,

		[Parameter(Position = 2)]
		$Root,

		[Parameter(Position = 3)]
		$Branches,

		[Parameter(Position = 4)]
		$Postfix,
		
		[Parameter(Position = 5)]
		$BranchName
	)

	$ErrorActionPreference = 'Stop'	

	$Root = $Config.GetValue('Root', $null, $Root)
	$Branches = $Config.GetValue('Branches', $null, $Branches)
	$Postfix = $Config.GetValue('Postfix', $null, $Postfix)
	$svn = $Config.GetValue('svn', 'svn')

	$branchUrl = $Config.ResolveSvnPath($Root, $Branches, $Postfix, $BranchName)

	Write-Message "Switching to branch $branchUrl"
	& $svn switch $branchUrl
	if ($?) {
		Write-Message "Switched successfully to $branchUrl"
	}
}