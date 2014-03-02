function Close-SvnBranch {
	[CmdletBinding()]
	param (
		$Root,
		$Branches,
		$Postfix,
		
		[Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
		[string[]] $BranchName
	)

	begin {
		$ErrorActionPreference = 'Stop'

		$config = Get-Configuration
		$Root = $config.GetValue('Root', $null, $Root)
		$Branches = $config.GetValue('Branches', $null, $Branches)
		$Postfix = $config.GetValue('Postfix', $null, $Postfix)
		$svn = $config.GetValue('svn', 'svn')
	}
	
	process {
		Write-Message "Closing branch $BranchName"
		
		$message = "Закрытие ветки $BranchName."
		$filename = [System.IO.Path]::GetTempFileName()
		$message | Out-File $filename -Encoding utf8
		
		& $svn mv `
		  (Format-Url @($Root, $Branches, $Postfix, $BranchName)) `
		  (Format-Url @($Root, $Branches, $Postfix, 'Closed', $BranchName)) `
		  -F $filename `
		  --encoding 'UTF-8'
		
		Remove-Item $filename
	}
}