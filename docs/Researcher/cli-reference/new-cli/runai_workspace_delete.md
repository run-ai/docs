## runai workspace delete

delete workspace

```
runai workspace delete [flags]
```

### Examples

```
runai workspace delete --name=<workload_name> (optional)--project=<project_name>
runai workspace delete --uuid=<workload_uuid>
```

### Options

```
  -h, --help             help for delete
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

* [runai workspace](runai_workspace.md)	 - workspace management

