function Switch-Branch {
	[CmdletBinding()]
	param (
		$Root = '^/Root',
		$Branches = 'branches',
		$Postfix = 'company',
		
		[Parameter(Mandatory = $true, Position = 1)]
		$BranchName
	)

	$branchUrl = Resolve-Branch $Root $Branches $Postfix $BranchName

	Write-Output "Switching to branch $branchUrl"
	svn switch $branchUrl
	if ($?) {
		Write-Output "Switched successfully to $branchUrl"
	}
}