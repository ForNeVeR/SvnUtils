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
	Switch-SvnBranch_Private $config $Root $Branches $Postfix $BranchName
}