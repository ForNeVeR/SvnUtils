function Get-SvnBranch {
	[CmdletBinding()]
	param (
		$Root,
		$Branches,
		$Postfix
	)

	$ErrorActionPreference = 'Stop'

	$config = Get-Configuration
	$Root = $config.GetValue('Root', $null, $Root)
	$Branches = $config.GetValue('Branches', $null, $Branches)
	$Postfix = $config.GetValue('Postfix', $null, $Postfix)
	$svn = $config.GetValue('svn', 'svn')

	& $svn list (Format-Url @($Root, $Branches, $Postfix)) | % {
		# svn list always returns a trailing slash we don't need.
		$_.Split('/')[0]
	}
}
