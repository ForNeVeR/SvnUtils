$ErrorActionPreference = 'Stop'

Import-Module ..\SvnUtils.psd1 -DisableNameChecking

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"
. "$here\Get-Configuration.ps1"
. "$here\Write-Message.ps1"
. "$here\Format-Url.ps1"
. "$here\Switch-SvnBranch_Private.ps1"

Describe "Merge-SvnPatch" {
    Context "With repository" {
        $tempRepoPath = "$env:TEMP\$([Guid]::NewGuid())"
        New-Item -ItemType Directory $tempRepoPath
        svnadmin create $tempRepoPath
        svn checkout "file:///$($tempRepoPath -replace '\\', '/')"
        Push-Location (Split-Path $tempRepoPath -Leaf)
        try {
            Copy-Item ..\..\SvnUtils.config .

            svn mkdir --parents Project/branches/postfix/b0
            svn commit -m 'Create repository structure and branch b0.'
            svn switch ^/Project/branches/postfix/b0 --ignore-ancestry

            'text1', 'text2' | Out-File file.txt -Encoding utf8
            svn add file.txt
            svn commit -m 'Create file.txt.'

            # Create branch b1 with 'text2' -> 'text3'
            Create-SvnBranch b0 b1
            'text1', 'text3' | Out-File file.txt -Encoding utf8
            svn commit -m 'text2 -> text3'

            # Create branch b2 with 'text1' -> 'text3'
            Create-SvnBranch b0 b2
            'text3', 'text2' | Out-File file.txt -Encoding utf8
            svn commit -m 'text1 -> text3'

            # Merge commit of b2 to b1 with two-url merge
            Switch-SvnBranch b1
            Merge-SvnBranch b0 -Source2Name b2 b1
            
            It 'merges diff between two trees to current branch successfully' {
                $content = (Get-Content file.txt) -join "`n"
                $expected = 'text3', 'text3' -join "`n"
                $content | Should Be $expected
            }
        } finally {
            Pop-Location
        }
    }
}
