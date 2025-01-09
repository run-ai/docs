## runai tensorflow suspend

suspend tf training

```
runai tensorflow suspend [WORKLOAD_NAME] [flags]
```

### Examples

```
# Suspend a tf training workload
runai training tf suspend <tf-name>

# Suspend a tf training workload in a specific project
runai training tf suspend <tf-name> -p <project_name>

# Suspend a tf training workload by UUID
runai training tf suspend --uuid=<tf_uuid>
```

### Options

```
  -h, --help             help for suspend
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

* [runai tensorflow](runai_tensorflow.md)	 - alias for tensorflow management

