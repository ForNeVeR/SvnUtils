function Switch-SvnBranch {
	[CmdletBinding()]
	param (
		$Root,
		$Branches,
		$Postfix,

		[Parameter(Mandatory = $true, Position = 1)]
		$BranchName,

		[switch]
		$IgnoreAncestry
	)

	$ErrorActionPreference = 'Stop'

	$config = Get-Configuration
	Switch-SvnBranch_Private `
		$config `
		$Root `
		$Branches `
		$Postfix `
		$BranchName `
		-IgnoreAncestry:$IgnoreAncestry
}
