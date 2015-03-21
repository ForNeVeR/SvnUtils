$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Apply-SvnPatch" {
    Context "With created patch" {
        $tempRepoPath = "$env:TEMP\$([Guid]::NewGuid())"
        New-Item -ItemType Directory $tempRepoPath
        svnadmin create $tempRepoPath
        svn checkout "file:///$($tempRepoPath -replace '\\', '/')"
        Set-Location (Split-Path $tempRepoPath -Leaf)
        'text1', 'text2' | Out-File file.txt -Encoding utf8
        svn add .\file.txt
        svn commit -m 'Initial state.'
        'text1' | Out-File file.txt -Encoding utf8
        cmd /c svn diff > current.patch
        svn revert file.txt

        It "applies the patch" {
            Apply-SvnPatch current.patch
            cat 'file.txt' | Should Be 'text1'
        }
    }
}
