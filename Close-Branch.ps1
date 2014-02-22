function Close-Branch {
	[CmdletBinding()]
	param(
		$Root = '^/Root',
		$Branches = '/branches',
		$Postfix = '/company',
		
		[Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
		[string[]]$Branch
	)
	
	process {
		Write-Host "Closing branch $Branch"
		
		$message = "Закрытие ветки $Branch."
		$filename = [System.IO.Path]::GetTempFileName()
		$message | Out-File $filename -Encoding utf8
		
		svn mv `
		  "$Root$Branches$Postfix/$Branch" `
		  "$Root$Branches$Postfix/Closed/$Branch" `
		  -F $filename `
		  --encoding 'UTF-8'
		
		Remove-Item $filename
	}
}