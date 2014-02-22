function Get-Branch {
	[CmdletBinding()]
	param (
		$Root,
		$Branches,
		$Postfix
	)

	$config = Get-Configuration
	$Root = $config.GetValue('Root', $null, $Root)
	$Branches = $config.GetValue('Branches', $null, $Branches)
	$Postfix = $config.GetValue('Postfix', $null, $Postfix)
	$svn = $config.GetValue('svn', 'svn')

	& $svn ls (Format-Url @($Root, $Branches, $Postfix))
}
