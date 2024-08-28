## runai distributed delete

delete distributed workload

```
runai distributed delete [DISTRIBUTED_NAME] [flags]
```

### Examples

```
# Delete a distributed workload with a default project
runai distributed delete <distributed_name>

# Delete a distributed workload with a specific project
runai distributed delete <distributed_name> -p <project_name>

# Delete a distributed workload by UUID
runai distributed delete --uuid=<distributed_uuid>

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
      --config-path string   config path; can be set by environment variable RUNAI_CLI_CONFIG_PATH (default "~/.runai/")
  -d, --debug                enable debug mode
  -q, --quiet                enable quiet mode, suppress all output except error messages
      --verbose              enable verbose mode
```

### SEE ALSO

* [runai distributed](runai_distributed.md)	 - distributed management

