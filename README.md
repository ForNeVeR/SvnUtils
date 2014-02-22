SvnUtils
========

This is the collection of PowerShell scripts for more comfortable
working with `svn` source control.

Configuration
-------------

The values for project root path, branches base path, postfix can be
configured through `SvnUtils.config` file placed in the current
directory or somewhere at parent directories. See the example
`SvnUtils.config` file bundled with the module.

You may want to tune the `Resolve-Branch` script that controls aliases
for branch names. Feel free to modify the corresponding script file.

Usage
-----

For all module commands to be acessible in yur environment, execute
the following command:

    Import-Module 'path\to\SvnUtils.psd1'

You may wish to add this import into your PowerShell profile (defined
by ypur `$PROFILE` variable).

Proposed workflow
-----------------

`SvnUtils` will best help you to retain the particular branching and
development model (scripts are also useful in many other situations,
but that's what they're written for).

That's the layout these scripts are supposed to maintain:

    ^ (repository root)
     + Project
       + trunk
       + branches
         + company1
           + working-branch2
           + working-branch3
           ...
           + Closed
             + working-branch1
             ...
         + company2
           ...

In this model, the *project root path* is `^/Project`, the *branches
base path* is `branches`, the *postfix* is `company1` (determined by
the user need, may be empty in many cases) and example *branch name*
is `working-branch1`.

Prerequisites
-------------

Most commands require you to install any console SVN client compatible
with your repositories. Some commands (for example, `Svn-Commit`
require additional tools such as
[TortoiseSvn](http://tortoisesvn.net/) and a Web browser (not
required, see below).

Supported commands
------------------

All commands should be executed inside an existing repository. Some
information (e.g. repository root and current branch name) will be
extracted from it.

Most parameters will be taken from configuration file if present; they
may be substituted with the user provided ones.

    Get-Branch `
        -Root <"Root" from config> `
        -Branches <"Branches" from config> `
        -Postfix <"Postfix" from config>

Returns list of all branches inside the specified directory.

    Create-Branch `
        -SourceRoot <"Root" from config> `
        -SourceBranches <"Branches" from config> `
        -SourcePostfix <"Postfix" from config> `
        -SourceName 'trunk' `
        -TargetRoot <the same as SourceRoot> `
        -TargetBranches <the same as SourceBranches> `
        -TargetPostfix <the same as SourcePostfix> `
        -TargetName <mandatory>

Creates a new branch inside the repository.

    Svn-Commit `
        -TortoiseProc 'TortoiseProc.exe' `
        -Clipboard 'clip.exe' `
        -ShowBrowser <flag; not enabled by default>

Commits the current changes with TortoiseSvn. Tries to detect merge
commits and present the nice commit messages for these cases. May also
copy the branch name and revision to clipboard and even open the
browser with the corresponding bug tracker page (currently
configurable only through `Svn-Commit.ps1` source).

    Revert-Branch -TortoiseProc 'TortoiseProc.exe'

Reverts the changes. Uses the TortoiseSvn GUI.

    Merge-Branch `
        -SourceRoot <"Root" from config> `
        -SourceBranches <"Branches" from config> `
        -SourcePostfix <"Postfix" from config> `
        -SourceName <mandatory> `
        -TargetRoot <the same as SourceRoot> `
        -TargetBranches <the same as SourceBranches> `
        -TargetPostfix <the same as SourcePostfix> `
        -TargetName 'trunk' `
        -RecordOnly <flag; not enabled by default>

Performs an SVN merge. May perform a `--record-only` merge (consult
SVN documentation).

    Switch-Branch `
        -Root <"Root" from config> `
        -Branches <"Branches" from config> `
        -Postfix <"Postfix" from config> `
        -BranchName <mandatory>

Switches the working copy to another branch.

    Resolve-Svn -TortoiseProc 'TortoiseProc.exe'

Show the conflict resolve dialog for the current directory.

    Close-Branch `
        -Root '^/Root' `
        -Branches '/branches' `
        -Postfix '/company' `
        -Branch <accepts multiple values from pipeline>

Closes the specified branches (i.e. moves them to the `Closed`
directory).
