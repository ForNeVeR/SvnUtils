function Resolve-Branch {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, Position = 1)]
		$BaseUrl,
		[Parameter(Mandatory = $true, Position = 2)]
		$BranchesBase,
		[Parameter(Mandatory = $true, Position = 3)]
		$BranchesPostfix,
		[Parameter(Mandatory = $true, Position = 4)]
		$BranchName
	)

	$ErrorActionPreference = 'Stop'

	$urlParts = switch ($BranchName) {
		'current' {
			$config = Get-Configuration
			$svn = $config.GetValue('svn', 'svn')
			$info = Parse-SvnInfo $(& $svn info)
			@($info['URL'])
		}

		'trunk' { @($BaseUrl, 'trunk') }
		'rc8574' { @($BaseUrl, 'Releases', 'RC_8574') }
		'adding' { @($BaseUrl, $BranchesBase, 'AddingProperty') }
		default { @($BaseUrl, $BranchesBase, $BranchesPostfix, $BranchName) }
	}

	Format-Url $urlParts
}
