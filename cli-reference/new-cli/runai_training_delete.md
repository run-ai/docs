## runai training delete

delete standard training workload

```
runai training delete [WORKLOAD_NAME] [flags]
```

### Examples

```
# Delete a standard training workload with a default project
runai training standard delete <standard-name>

# Delete a standard training workload with a specific project
runai training standard delete <standard-name> -p <project_name>

# Delete a standard training workload by UUID
runai training standard delete --uuid=<standard_uuid> -p <project_name>
```

### Options

```
  -h, --help             help for delete
  -p, --project string   Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
  -u, --uuid string      The UUID of the workload
```

### Options inherited from parent commands

```
      --config-file string   config file name; can be set by environment variable RUNAI_CLI_CONFIG_FILE (default "config.json")
      --config-path string   config path; can be set by environment variable RUNAI_CLI_CONFIG_PATH
  -d, --debug                enable debug mode
  -q, --quiet                enable quiet mode, suppress all output except error messages
      --verbose              enable verbose mode
```

### SEE ALSO

* [runai training](runai_training.md)	 - training management

