function Switch-Branch {
	[CmdletBinding()]
	param (
		[string] $RootUrl = '^/Root',
		[string] $BranchesBase = 'branches',
		[string] $BranchesPostfix = 'company',
		[Parameter(Mandatory = $true, Position = 1)]
		[string] $BranchName
	)

	$branchUrl = Resolve-Branch $RootUrl $BranchesBase $BranchesPostfix $BranchName

	Write-Output "Switching to branch $branchUrl"
	svn switch $branchUrl
	if ($?) {
		Write-Output "Switched successfully to $branchUrl"
	}
}