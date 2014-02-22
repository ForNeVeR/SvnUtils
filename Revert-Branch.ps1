function Revert-Branch {
	[CmdletBinding()]

	$config = Get-Configuration
	$TortoiseProc = $config.GetValue('TortoiseProc', 'TortoiseProc')

	$arguments = @(
		'/command:revert'
		"/path:`"$(Resolve-Path .)`""
	)

	Start-Process $TortoiseProc $arguments -Wait
}
