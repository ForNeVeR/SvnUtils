function Create-Branch {
	[CmdletBinding()]
	param (
		$SourceRoot,
		$SourceBranches,
		$SourcePostfix,

		[Parameter(Mandatory = $true, Position = 1)]
		$SourceName = 'trunk',

		$TargetRoot,
		$TargetBranches,
		$TargetPostfix,

		[Parameter(Mandatory = $true, Position = 2)]
		$TargetName
	)

	$config = Get-Configuration
	$SourceRoot = $config.GetValue('Root', $null, $SourceRoot)
	$SourceBranches = $config.GetValue('Branches', $null, $SourceBranches)
	$SourcePostfix = $config.GetValue('Postfix', $null, $SourcePostfix)
	$TargetRoot = $config.GetValue('Root', $SourceRoot, $TargetRoot)
	$TargetBranches = $config.GetValue('Branches', $SourceBranches, $TargetBranches)
	$TargetPostfix = $config.GetValue('Postfix', $SourcePostfix, $TargetPostfix)
	$svn = $config.GetValue('svn', 'svn')

	$baseUrl = Resolve-Branch $SourceRoot $SourceBranches $SourcePostfix $SourceName
	$branchUrl = Resolve-Branch $TargetRoot $TargetBranches $TargetPostfix $TargetName

	Write-Output 'Branching:'
	Write-Output "$baseUrl -> $branchUrl"

	# Check if branch already exists
	& $svn ls $branchUrl --depth empty 2>&1 | Out-Null
	$exists = $?
	if (-not $exists) {
		$message = "Создание ветки для работ над задачей $TargetName."
		$filename = [System.IO.Path]::GetTempFileName()
		$message | Out-File $filename -Encoding utf8

		& $svn copy $baseUrl $branchUrl -F $filename --encoding 'UTF-8'

		Remove-Item $filename
	} else {
		Write-Warning "Branch already exists"
	}

	& $svn switch $branchUrl
}
