function Write-Message {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, Position = 1)]
		$Message
	)

	$ErrorActionPreference = 'Stop'

	Write-Host @('=>', $Message) -ForegroundColor White
}