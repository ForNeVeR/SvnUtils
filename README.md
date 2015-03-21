SvnUtils [![Build status](https://ci.appveyor.com/api/projects/status/p349091qxfxsmde1/branch/develop?svg=true)](https://ci.appveyor.com/project/ForNeVeR/svnutils/branch/develop)
========

This is the collection of PowerShell scripts for more comfortable
working with `svn` source control.

Configuration
-------------

The values for project root path, branches base path, postfix can be
configured through `SvnUtils.config` file placed in the current
directory or somewhere at parent directories. See the example
`SvnUtils.config` file bundled with the module.

#### Branch name resolving

`SvnUtils` includes some predefined branch aliases:

* `current` means the current working copy branch in any context;
* `trunk` means the trunk branch.

You may add your own branch resolving strategies with the
`SvnPathResolver` function in the configuration file. Predefined
`current` and `trunk` aliases cannot be overridden.

#### Messages

Some commands (e.g. `Create-SvnBranch` and `Close-SvnBranch`) generate
messages for SVN log. These messages may be localized in the
configuration file.

Usage
-----

For all module commands to be acessible in yur environment, execute
the following command:

    Import-Module 'path\to\SvnUtils.psd1' -DisableNameChecking

You may wish to add this import into your PowerShell profile (defined
by your `$PROFILE` variable).

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
with your repositories. Some commands (for example, `Commit-SvnChange`
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

    Get-SvnBranch `
        -Root <"Root" from config> `
        -Branches <"Branches" from config> `
        -Postfix <"Postfix" from config>

Returns list of all branches inside the specified directory.

    Create-SvnBranch `
        -SourceRoot <"Root" from config> `
        -SourceBranches <"Branches" from config> `
        -SourcePostfix <"Postfix" from config> `
        -SourceName 'trunk' `
        -TargetRoot <the same as SourceRoot> `
        -TargetBranches <the same as SourceBranches> `
        -TargetPostfix <the same as SourcePostfix> `
        -TargetName <mandatory>

Creates a new branch inside the repository.

    Get-SvnPatch `
        -OldRevision <mandatory> `
        -NewRevision <mandatory> `
        -OutputPath <mandatory>

Get the patch in the SVN format and save it to the `OutputPath`.

    Apply-SvnPatch [-PatchFilename] <mandatory>

Applies the patch file to the current directory with `TortoiseMerge`.

    Commit-SvnChange -ShowBrowser <flag; not enabled by default>

Commits the current changes with TortoiseSvn. Tries to detect merge
commits and present the nice commit messages for these cases. May also
copy the branch name and revision to clipboard and even open the
browser with the corresponding bug tracker page (currently
configurable only through `Svn-Commit.ps1` source).

    Revert-SvnChange

Reverts the working copy changes using the TortoiseSvn GUI.

    Merge-SvnBranch `
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

    Switch-SvnBranch `
        -Root <"Root" from config> `
        -Branches <"Branches" from config> `
        -Postfix <"Postfix" from config> `
        -BranchName <mandatory>

Switches the working copy to another branch.

    Resolve-SvnConflict

Show the TortoiseSvn conflict resolve dialog for the current
directory.

    Close-SvnBranch `
        -Root <"Root" from config> `
        -Branches <"Branches" from config> `
        -Postfix <"Postfix" from config> `
        -Closed <"Closed" from config> `
        -BranchName <accepts multiple values from pipeline>

Closes the specified branches (i.e. moves them to the `Closed`
directory).

Tests
-----
There are tests created using [Pester](https://github.com/pester/Pester/). To invoke them, install Pester (for example,
with `choco install pester`) and run:

    cd tests
    Invoke-Pester -Path ..
