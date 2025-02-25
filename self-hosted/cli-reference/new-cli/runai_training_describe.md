## runai training describe

describe standard training

```
runai training describe [WORKLOAD_NAME] [flags]
```

### Examples

```
# Describe a standard training workload with a default project
runai training standard describe <standard-name>

# Describe a standard training workload in a specific project
runai training standard describe <standard-name> -p <project_name>

# Describe a standard training workload by UUID
runai training standard describe --uuid=<standard_uuid>

# Describe a standard training workload with specific output format
runai training standard describe <standard-name> -o json

# Describe a standard training workload with specific sections
runai training standard describe <standard-name> --general --compute --pods --events --networks

# Describe a standard training workload with container details and custom limits
runai training standard describe <standard-name> --containers --pod-limit 20 --event-limit 100
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
      --config-path string   config path; can be set by environment variable RUNAI_CLI_CONFIG_PATH
  -d, --debug                enable debug mode
  -q, --quiet                enable quiet mode, suppress all output except error messages
      --verbose              enable verbose mode
```

### SEE ALSO

* [runai training](runai_training.md)	 - training management

