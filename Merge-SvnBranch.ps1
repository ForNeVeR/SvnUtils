function Merge-SvnBranch {
	[CmdletBinding()]
	param (
		$SourceRoot,
		$SourceBranches,
		$SourcePostfix,

		[Parameter(Mandatory = $true, Position = 1)]
		$SourceName,

        $Source2Root,
		$Source2Branches,
		$Source2Postfix,
		$Source2Name,

		$TargetRoot,
		$TargetBranches,
		$TargetPostfix,

		[Parameter(Mandatory = $true, Position = 2)]
		$TargetName = 'trunk',

		$Revisions,

		[switch]
		$RecordOnly = $false
	)

	$ErrorActionPreference = 'Stop'

	$config = Get-Configuration
	$SourceRoot = $config.GetValue('Root', $null, $SourceRoot)
	$SourceBranches = $config.GetValue('Branches', $null, $SourceBranches)
	$SourcePostfix = $config.GetValue('Postfix', $null, $SourcePostfix)
    $Source2Root = $config.GetValue('Root', $null, $Source2Root)
	$Source2Branches = $config.GetValue('Branches', $null, $Source2Branches)
	$Source2Postfix = $config.GetValue('Postfix', $null, $Source2Postfix)
	$TargetRoot = $config.GetValueWithPriority($SourceRoot, $TargetRoot)
	$TargetBranches = $config.GetValueWithPriority($SourceBranches, $TargetBranches)
	$TargetPostfix = $config.GetValueWithPriority($SourcePostfix, $TargetPostfix)
	$svn = $config.GetValue('svn', 'svn')

	$sourceUrl = $config.ResolveSvnPath($SourceRoot, $SourceBranches, $SourcePostfix, $SourceName)
    if ($Source2Name) {
        $source2Url = $config.ResolveSvnPath($Source2Root, $Source2Branches, $Source2Postfix, $Source2Name)
    }

	Switch-SvnBranch_Private `
	  $config `
	  -Root $TargetRoot `
	  -Branches $TargetBranches `
	  -Postfix $TargetPostfix `
	  $TargetName

	$arguments = @('merge')
	if ($RecordOnly) {
		$arguments += '--record-only'
	}
	if ($Revisions) {
		$arguments += '-r' + $Revisions
	}
    $arguments += $sourceUrl
    if ($source2Url) {
        $arguments += $source2Url
    }

	Write-Message "Starting $svn $arguments"
	Start-Process $svn -ArgumentList $arguments -NoNewWindow -Wait
}
