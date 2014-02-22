param(
	[string] $TortoiseProc = 'TortoiseProc.exe'
)

$arguments = @(
	'/command:revert'
	"/path:`"$(Resolve-Path .)`""
)

Start-Process $TortoiseProc $arguments -Wait
