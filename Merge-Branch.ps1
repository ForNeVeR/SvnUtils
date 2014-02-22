param(
    $SourceRoot = '^/Root',
    $SourceBranchesBase = 'branches',
    $SourceBranchesPostfix = 'company',
    [Parameter(Mandatory = $true, Position = 1)]
    $SourceName,

    $TargetRoot = $SourceRoot,
    $TargetBranchesBase = $SourceBranchesBase,
    $TargetBranchesPostfix = $SourceBranchesPostfix,

    [Parameter(Mandatory = $true, Position = 2)]
    $TargetName = 'trunk',

	[switch]
	$RecordOnly = $false
)

$scriptPath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptPath
& $dir\Switch-Branch.ps1 -RootUrl $TargetRoot -BranchesBase $TargetBranchesBase -BranchesPostfix $TargetBranchesPostfix $TargetName

$branchUrl = & $dir\Resolve-Branch.ps1 $SourceRoot $SourceBranchesBase $SourceBranchesPostfix $SourceName

if ($RecordOnly) {
	$option = '--record-only'
} else {
	$option = ''
}

Write-Output "Merging branch $branchUrl"
svn merge $option $branchUrl
