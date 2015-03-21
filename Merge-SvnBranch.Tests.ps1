$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Merge-SvnPatch" {
    Context "With repository" {
        $tempRepoPath = "$env:TEMP\$([Guid]::NewGuid())"
        New-Item -ItemType Directory $tempRepoPath
        svnadmin create $tempRepoPath
        svn checkout "file:///$($tempRepoPath -replace '\\', '/')"
        Set-Location (Split-Path $tempRepoPath -Leaf)
        # TODO: Create configuration file for current repository
        # TODO: Create file with 'text1', 'text2' in branch b0
        # TODO: Create branch b1 with 'text2' -> 'text3'
        # TODO: Create branch b2 with 'text1' -> 'text3'
        # TODO: Merge commit of b2 to b1 with two-url merge

        It 'calls TortoiseMerge' {
            $false Should Be $true # TODO: Check file content to be exactly 'text3', 'text3'
        }
    }
}
