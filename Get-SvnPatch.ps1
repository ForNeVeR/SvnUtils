function Get-SvnPatch {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, Position = 1)]
		$OldRevision,

		[Parameter(Mandatory = $true, Position = 2)]
		$NewRevision,

		[Parameter(Mandatory = $true, Position = 3)]
		$OutputPath
	)

	$ErrorActionPreference = 'Stop'

	$config = Get-Configuration
	$svn = $config.GetValue('svn', 'svn')

	$command = "$svn diff --revision $($OldRevision):$NewRevision > $OutputPath"

	Write-Message "Executing $command"
	cmd /c $command
}