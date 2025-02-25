## runai xgboost suspend

suspend xgboost training

```
runai xgboost suspend [WORKLOAD_NAME] [flags]
```

### Examples

```
# Suspend a xgboost training workload
runai training xgboost suspend <xgboost-name>

# Suspend a xgboost training workload in a specific project
runai training xgboost suspend <xgboost-name> -p <project_name>

# Suspend a xgboost training workload by UUID
runai training xgboost suspend --uuid=<xgboost_uuid>
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

* [runai xgboost](runai_xgboost.md)	 - alias for xgboost management

