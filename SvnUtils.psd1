@{
	ModuleVersion = '1.0'
	GUID = '0e425261-51fa-4bd0-9227-1b6acd799a9a'
	Author = 'ForNeVeR'
	CompanyName = 'CodingTeam'
	Copyright = '(c) 2015 ForNeVeR. All rights reserved.'
	# Description = ''
	# PowerShellVersion = ''
	# PowerShellHostName = ''
	# PowerShellHostVersion = ''
	# DotNetFrameworkVersion = ''
	# CLRVersion = ''
	# ProcessorArchitecture = ''
	# RequiredModules = @()
	# RequiredAssemblies = @()
	# ScriptsToProcess = @()
	# TypesToProcess = @()
	# FormatsToProcess = @()
	NestedModules = @(
        'Apply-SvnPatch.ps1'
		'Close-SvnBranch.ps1'
		'Commit-SvnChange.ps1'
		'Create-SvnBranch.ps1'
		'Format-Url.ps1'
		'Get-Configuration.ps1'
		'Get-SvnBranch.ps1'
		'Get-SvnPatch.ps1'
		'Merge-SvnBranch.ps1'
		'Parse-SvnInfo.ps1'
		'Resolve-SvnConflict.ps1'
		'Revert-SvnChange.ps1'
		'Switch-SvnBranch.ps1'
		'Switch-SvnBranch_Private.ps1'
		'Write-Message.ps1'
	)
	FunctionsToExport = @(
        'Apply-SvnPatch'
		'Get-SvnBranch'
		'Get-SvnPatch'
		'Create-SvnBranch'
		'Commit-SvnChange'
		'Revert-SvnChange'
		'Merge-SvnBranch'
		'Switch-SvnBranch'
		'Resolve-SvnConflict'
		'Close-SvnBranch'
	)
	# CmdletsToExport = '*'
	# VariablesToExport = '*'
	# AliasesToExport = '*'
	# ModuleList = @()
	# FileList = @()
	# PrivateData = ''
	# HelpInfoURI = ''
	# DefaultCommandPrefix = ''
}
