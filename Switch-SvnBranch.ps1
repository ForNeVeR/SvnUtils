function Switch-SvnBranch {
	[CmdletBinding()]
	param (
		$Root,
		$Branches,
		$Postfix,
		
		[Parameter(Mandatory = $true, Position = 1)]
		$BranchName
	)

	$ErrorActionPreference = 'Stop'	

	$config = Get-Configuration
	$Root = $config.GetValue('Root', $null, $Root)
	$Branches = $config.GetValue('Branches', $null, $Branches)
	$Postfix = $config.GetValue('Postfix', $null, $Postfix)
	$svn = $config.GetValue('svn', 'svn')

	$branchUrl = Resolve-SvnPath $Root $Branches $Postfix $BranchName

	Write-Output "Switching to branch $branchUrl"
	& $svn switch $branchUrl
	if ($?) {
		Write-Output "Switched successfully to $branchUrl"
	}
}