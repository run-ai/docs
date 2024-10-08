## runai training pytorch describe

describe pytorch training

```
runai training pytorch describe [WORKLOAD_NAME] [flags]
```

### Examples

```
# Describe a pytorch training workload with a default project
runai training pytorch describe <pytorch-name>

# Describe a pytorch training workload in a specific project
runai training pytorch describe <pytorch-name> -p <project_name>

# Describe a pytorch training workload by UUID
runai training pytorch describe --uuid=<pytorch_uuid>

# Describe a pytorch training workload with specific output format
runai training pytorch describe <pytorch-name> -o json

# Describe a pytorch training workload with specific sections
runai training pytorch describe <pytorch-name> --general --compute --pods --events --networks

# Describe a pytorch training workload with container details and custom limits
runai training pytorch describe <pytorch-name> --containers --pod-limit 20 --event-limit 100
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

* [runai training pytorch](runai_training_pytorch.md)	 - pytorch management

