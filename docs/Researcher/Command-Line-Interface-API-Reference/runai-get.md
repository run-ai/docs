## Description

Display details of a training job

## Synopsis

    runai get job-name 
        [--output value | -o value]  

        [--backward-compatibility | -b] 
        [--loglevel value] 
        [--project string | -p string] 
        [--help | -h]


## Options

<job-name\> the name of the job to run the command in

-o | --output

>  Output format. One of: json|yaml|wide

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

The command will show the job properties and status as well as lifecycle events and list of pods

## See Also