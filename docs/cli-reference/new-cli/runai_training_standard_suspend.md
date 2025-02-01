## runai training standard suspend

suspend standard training

```
runai training standard suspend [WORKLOAD_NAME] [flags]
```

### Examples

```
# Suspend a standard training workload
runai training standard suspend <standard-name>

# Suspend a standard training workload in a specific project
runai training standard suspend <standard-name> -p <project_name>

# Suspend a standard training workload by UUID
runai training standard suspend --uuid=<standard_uuid>
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

* [runai training standard](runai_training_standard.md)	 - standard training management

