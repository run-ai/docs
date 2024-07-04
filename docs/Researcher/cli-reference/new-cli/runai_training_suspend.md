## runai training suspend

suspend training

```
runai training suspend [flags]
```

### Examples

```
runai training --name=<training_name> --project=<project_name>
runai training suspend --uuid=<training_workspace_uuid>
```

### Options

```
  -h, --help             help for suspend
      --name string      The name of the workload
      --project string   Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
      --uuid string      The UUID of the workload
```

### Options inherited from parent commands

```
      --config-file string   config file name; can be set by environment variable RUNAI_CLI_CONFIG_FILE (default "config.json")
      --config-path string   config path; can be set by environment variable RUNAI_CLI_CONFIG_PATH (default "~/.runai/")
  -d, --debug                enable debug mode
  -v, --verbose              enable verbose mode
```

### SEE ALSO

* [runai training](runai_training.md)	 - training management

