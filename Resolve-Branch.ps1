param(
	[Parameter(Mandatory = $true, Position = 1)]
	$BaseUrl,
	[Parameter(Mandatory = $true, Position = 2)]
	$BranchesBase,
	[Parameter(Mandatory = $true, Position = 3)]
	$BranchesPostfix,
	[Parameter(Mandatory = $true, Position = 4)]
	$BranchName
)

$urlParts = switch ($BranchName) {
	'current' {
		$info = & $dir\Parse-SvnInfo.ps1 $(svn info)
		@($info['URL'])
	}

	'trunk' { @($BaseUrl, 'trunk') }
	'rc8574' { @($BaseUrl, 'Releases', 'RC_8574') }
	'adding' { @($BaseUrl, $BranchesBase, 'AddingProperty') }
	default { @($BaseUrl, $BranchesBase, $BranchesPostfix, $BranchName) }
}

$urlParts = $urlParts | ? {
	$_
}

$branchUrl = [string]::Join('/', $urlParts)
$branchUrl
