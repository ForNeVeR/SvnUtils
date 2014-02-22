function Create-Branch {
	[CmdletBinding()]
	param(
		$SourceRoot = '^/Root',
		$SourceBranchesBase = 'branches',
		$SourcePostfix = 'company',

		[Parameter(Mandatory = $true, Position = 1)]
		$SourceName = 'trunk',

		$TargetRoot = $SourceRoot,
		$TargetBranchesBase = $SourceBranchesBase,
		$TargetPostfix = $SourcePostfix,

		[Parameter(Mandatory = $true, Position = 2)]
		$TargetName
	)

	$baseUrl = Resolve-Branch $SourceRoot $SourceBranchesBase $SourcePostfix $SourceName
	$branchUrl = Resolve-Branch $TargetRoot $TargetBranchesBase $TargetPostfix $TargetName

	Write-Output 'Branching:'
	Write-Output "$baseUrl -> $branchUrl"

	# Check if branch already exists
	svn ls $branchUrl --depth empty 2>&1 | Out-Null
	$exists = $?
	if (-not $exists) {
		$message = "Создание ветки для работ над задачей $TargetName."
		$filename = [System.IO.Path]::GetTempFileName()
		$message | Out-File $filename -Encoding utf8

		svn copy $baseUrl $branchUrl -F $filename --encoding 'UTF-8'

		Remove-Item $filename
	} else {
		Write-Warning "Branch already exists"
	}

	svn sw $branchUrl
}
