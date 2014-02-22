function Format-Url {
	[CmdletBinding()]
	param (
		[string[]] $Parts
	)

	$ErrorActionPreference = 'Stop'

	# Remove empty entries:
	$parts = $parts | ? { $_ }

	[string]::Join('/', $parts)
}