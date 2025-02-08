## runai training tensorflow delete

delete tf training workload

```
runai training tensorflow delete [WORKLOAD_NAME] [flags]
```

### Examples

```
# Delete a tf training workload with a default project
runai training tf delete <tf-name>

# Delete a tf training workload with a specific project
runai training tf delete <tf-name> -p <project_name>

# Delete a tf training workload by UUID
runai training tf delete --uuid=<tf_uuid> -p <project_name>
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

* [runai training tensorflow](runai_training_tensorflow.md)	 - tensorflow management

