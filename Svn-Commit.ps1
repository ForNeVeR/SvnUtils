function Svn-Commit {
	[CmdletBinding()]
	param(
		[switch] $ShowBrowser
	)

	$ErrorActionPreference = 'Stop'

	$config = Get-Configuration
	$svn = $config.GetValue('svn', 'svn')
	$TortoiseProc = $config.GetValue('TortoiseProc', 'TortoiseProc')
	$clip = $config.GetValue('clip', 'clip')

	function Get-MergedBranch() {
		$mergeInfo = & $svn diff --non-recursive | Select-String 'Merged'
		$parsedInfos = $mergeInfo | % {
			if ($_ -match '(/.*?):r(\d+)-(\d+)') {
				[pscustomobject] @{
					Url = $Matches[1];
					StartRevision = $Matches[2];
					EndRevision = $Matches[3]
				}
			}
		}
	
		$info = $parsedInfos | Sort-Object -Property EndRevision -Descending | Select-Object -First 1
		$info
	}

	function Get-SvnLog($logUrl) {
		$oldEncoding = [Console]::OutputEncoding
		try {
			[Console]::OutputEncoding = [Text.Encoding]::UTF8
			$log = [xml] $(& $svn log "^/$logUrl" --limit 1 --xml)
			$log.log.logentry.msg
		} finally {
			[Console]::OutputEncoding = $oldEncoding
		}
	}

	$info = Parse-SvnInfo $(svn info)
	$branch = $info['URL']
	$root = $info['Repository Root']
	$branchName = $branch.Split('/')[-1]

	$mergedBranch = Get-MergedBranch
	if ($mergedBranch) {
		$mergedBranchUrl = $mergedBranch.Url
		$mergedBranchName = $mergedBranchUrl.Split('/')[-1]
		$mergedRevision = $mergedBranch.EndRevision
	
		Write-Host "Merge detected: " -NoNewline -ForegroundColor White
		Write-Host "$mergedBranchName ($mergedBranchUrl, rev. $mergedRevision)."
	
		$escapedName = [regex]::Escape("$mergedBranchName")
		$log = $(Get-SvnLog $mergedBranchUrl) -replace "$($escapedName):?\s+", ''

		$logMessage = "Merge $mergedBranchName, rev. $($mergedRevision): $log"
	} else {
		$logMessage = "${branchName}: "
	}

	$arguments = @(
		'/command:commit'
		"/path:`"$(Resolve-Path .)`""
		"/logmsg:`"$logMessage`""
	)

	Write-Host "Starting $TortoiseProc..." -ForegroundColor White
	Start-Process $TortoiseProc $arguments -Wait

	& $svn update

	$info = Parse-SvnInfo $(& $svn info)
	$revision = $info['Last Changed Rev']

	$url = "http://jira/browse/$branchName"
	$branchId = 'http://svb/svn/project' + $branch.Substring($root.Length)
	$message = "$branchId, rev. $revision."

	$message | & $clip

	Write-Host "Message copied into clipboard." -ForegroundColor White

	if ($ShowBrowser -and $branchName -ne 'trunk') {
		start $url
	}
}
