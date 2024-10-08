## runai xgboost describe

describe xgboost training

```
runai xgboost describe [WORKLOAD_NAME] [flags]
```

### Examples

```
# Describe a xgboost training workload with a default project
runai training xgboost describe <xgboost-name>

# Describe a xgboost training workload in a specific project
runai training xgboost describe <xgboost-name> -p <project_name>

# Describe a xgboost training workload by UUID
runai training xgboost describe --uuid=<xgboost_uuid>

# Describe a xgboost training workload with specific output format
runai training xgboost describe <xgboost-name> -o json

# Describe a xgboost training workload with specific sections
runai training xgboost describe <xgboost-name> --general --compute --pods --events --networks

# Describe a xgboost training workload with container details and custom limits
runai training xgboost describe <xgboost-name> --containers --pod-limit 20 --event-limit 100
```

### Options

```
      --compute             Show compute information (default true)
      --containers          Include container information in pods
      --event-limit int32   Limit the number of events displayed (-1 for no limit) (default 50)
      --events              Show events information (default true)
      --general             Show general information (default true)
  -h, --help                help for describe
      --networks            Show networks information (default true)
  -o, --output string       Output format (table, json, yaml) (default "table")
      --pod-limit int32     Limit the number of pods displayed (-1 for no limit) (default 10)
      --pods                Show pods information (default true)
  -p, --project string      Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
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

* [runai xgboost](runai_xgboost.md)	 - alias for xgboost management

