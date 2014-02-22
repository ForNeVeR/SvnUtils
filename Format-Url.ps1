function Format-Url {
	[CmdletBinding()]
	param (
		[string[]] $Parts
	)

	# Remove empty entries:
	$parts = $parts | ? { $_ }

	[string]::Join('/', $parts)
}