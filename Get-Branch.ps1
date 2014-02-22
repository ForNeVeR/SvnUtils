function Get-Branch {
	[CmdletBinding()]
	param(
		$Root = '^/Root',
		$Branches = '/branches',
		$Postfix = '/company'
	)

	svn ls $Root$Branches$Postfix
}
