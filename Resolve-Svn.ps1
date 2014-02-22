param(
	[string] $TortoiseProc = 'TortoiseProc.exe'
)

$arguments = @(
	'/command:resolve'
	"/path:`"$(Resolve-Path .)`""
)

Start-Process $TortoiseProc $arguments -Wait
