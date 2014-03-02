function Revert-SvnChange {
	[CmdletBinding()]
	$ErrorActionPreference = 'Stop'

	$config = Get-Configuration
	$TortoiseProc = $config.GetValue('TortoiseProc', 'TortoiseProc')

	$arguments = @(
		'/command:revert'
		"/path:`"$(Resolve-Path .)`""
	)

	Write-Message "Starting $TortoiseProc"
	Start-Process $TortoiseProc $arguments -Wait
}
