@{
	ModuleVersion = '1.0'
	GUID = '0e425261-51fa-4bd0-9227-1b6acd799a9a'
	Author = 'ForNeVeR'
	CompanyName = 'Codingteam'
	Copyright = '(c) 2014 ForNeVeR. All rights reserved.'
	# Description = ''
	# PowerShellVersion = ''
	# PowerShellHostName = ''
	# PowerShellHostVersion = ''
	# DotNetFrameworkVersion = ''
	# CLRVersion = ''
	# ProcessorArchitecture = ''
	# RequiredModules = @()
	# RequiredAssemblies = @()
	ScriptsToProcess = @(
		'Close-SvnBranch.ps1'
		'Commit-SvnChange.ps1'
		'Create-SvnBranch.ps1'
		'Format-Url.ps1'
		'Get-Configuration.ps1'
		'Get-SvnBranch.ps1'
		'Merge-SvnBranch.ps1'
		'Parse-SvnInfo.ps1'
		'Resolve-SvnConflict.ps1'
		'Resolve-SvnPath.ps1'
		'Revert-SvnChange.ps1'
		'Switch-SvnBranch.ps1'
	)
	# TypesToProcess = @()
	# FormatsToProcess = @()
	# NestedModules = @()
	FunctionsToExport = @(
		'Get-SvnBranch'
		'Create-SvnBranch'
		'Commit-SvnChange'
		'Revert-SvnChange'
		'Merge-SvnBranch'
		'Swtich-SvnBranch'
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
