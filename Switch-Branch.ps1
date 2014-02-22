function Switch-Branch {
	[CmdletBinding()]
	param (
		$Root,
		$Branches,
		$Postfix,
		
		[Parameter(Mandatory = $true, Position = 1)]
		$BranchName
	)

	$Root = $config.GetValue('Root', $null, $Root)
	$Branches = $config.GetValue('Branches', $null, $Branches)
	$Postfix = $config.GetValue('Postfix', $null, $Postfix)

	$branchUrl = Resolve-Branch $Root $Branches $Postfix $BranchName

	Write-Output "Switching to branch $branchUrl"
	svn switch $branchUrl
	if ($?) {
		Write-Output "Switched successfully to $branchUrl"
	}
}