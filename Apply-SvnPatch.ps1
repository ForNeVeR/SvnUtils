function Apply-SvnPatch {
	[CmdletBinding()]
	param (
        [Parameter(Mandatory = $true)]
		$PatchFilename
	)

    $ErrorActionPreference = 'Stop'

    Write-Message "Starting TortoiseMerge"
    Write-Message "TortoiseMerge /diff:""$(Resolve-Path $PatchFilename)"" /patchpath:""$(Get-Location)"""
    TortoiseMerge "/diff:""$(Resolve-Path $PatchFilename)""" "/patchpath:""$(Get-Location)"""
}
