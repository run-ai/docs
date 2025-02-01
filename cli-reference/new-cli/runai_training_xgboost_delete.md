## runai training xgboost delete

delete xgboost training workload

```
runai training xgboost delete [WORKLOAD_NAME] [flags]
```

### Examples

```
# Delete a xgboost training workload with a default project
runai training xgboost delete <xgboost-name>

# Delete a xgboost training workload with a specific project
runai training xgboost delete <xgboost-name> -p <project_name>

# Delete a xgboost training workload by UUID
runai training xgboost delete --uuid=<xgboost_uuid> -p <project_name>
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

* [runai training xgboost](runai_training_xgboost.md)	 - xgboost management

