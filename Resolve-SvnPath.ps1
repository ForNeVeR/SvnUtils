function Resolve-SvnPath {
	[CmdletBinding()]
	param (
		[Parameter(Position = 1)]
		$BaseUrl,
		[Parameter(Position = 2)]
		$BranchesBase,
		[Parameter(Position = 3)]
		$BranchesPostfix,
		[Parameter(Position = 4)]
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
