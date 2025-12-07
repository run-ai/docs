## runai inference describe

describe inference

```
runai inference describe [WORKLOAD_NAME] [flags]
```

### Examples

```
# Describe a inference workload with a default project
runai inference describe <inference-name>

# Describe a inference workload in a specific project
runai inference describe <inference-name> -p <project_name>

# Describe a inference workload by UUID
runai inference describe --uuid=<inference_uuid>

# Describe a inference workload with specific output format
runai inference describe <inference-name> -o json

# Describe a inference workload with specific sections
runai inference describe <inference-name> --general --compute --pods --events --networks

# Describe a inference workload with container details and custom limits
runai inference describe <inference-name> --containers --pod-limit 20 --event-limit 100
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
      --sortEvents string   Sort the displayed events in ascending/descending order (asc, desc) (default "asc")
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

* [runai inference](runai_inference.md)	 - inference management

