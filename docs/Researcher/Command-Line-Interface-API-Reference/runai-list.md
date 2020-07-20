## Description

Show list of jobs

## Synopsis

    runai list job-name 
        [--all-projects | -A]  

        [--backward-compatibility | -b] 
        [--loglevel value] 
        [--project string | -p string] 
        [--help | -h]

## Options

--all-projects | -A

>  Show jobs from all projects

### Global Flags

--backward-compatibility | -b

>   Backward compatibility mode to provide support for Jobs created with older versions of the CLI. See [Migrating to Permission Aware CLI](../Command-Line-Interface/Migrating-to-Permission-Aware-CLI.md) for further information

--loglevel (string)

>  Set the logging level. One of: debug|info|warn|error (default "info")

--project | -p (string)

>  Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use``runai project set <project-name>``.

--help | -h

>  Show help text

## Output

A list of jobs will show. To show details for a specific job see [runai get](runai-get.md)

## See Also

