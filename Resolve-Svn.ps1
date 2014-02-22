function Resolve-Svn {
	[CmdletBinding()]
	
	$config = Get-Configuration
	$TortoiseProc = $config.GetValue('TortoiseProc', 'TortoiseProc')

	$arguments = @(
		'/command:resolve'
		"/path:`"$(Resolve-Path .)`""
	)

	Start-Process $TortoiseProc $arguments -Wait
}
