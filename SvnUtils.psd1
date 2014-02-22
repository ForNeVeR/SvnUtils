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
		'Close-Branch.ps1'
		'Create-Branch.ps1'
		'Get-Branch.ps1'
		'Merge-Branch.ps1'
		'Parse-SvnInfo.ps1'
		'Resolve-Branch.ps1'
		'Resolve-Svn.ps1'
		'Revert-Branch.ps1'
		'Svn-Commit.ps1'
		'Switch-Branch.ps1'
	)
	# TypesToProcess = @()
	# FormatsToProcess = @()
	# NestedModules = @()
	FunctionsToExport = @(
		'Get-Branch'
		'Create-Branch'
		'Svn-Commit'
		'Revert-Branch'
		'Merge-Branch'
		'Swtich-Branch'
		'Resolve-Svn'
		'Close-Branch'
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
