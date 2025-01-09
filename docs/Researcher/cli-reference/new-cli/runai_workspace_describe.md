## runai workspace describe

describe workspace

```
runai workspace describe [WORKLOAD_NAME] [flags]
```

### Examples

```
# Describe a workspace workload with a default project
runai workspace describe <workspace-name>

# Describe a workspace workload in a specific project
runai workspace describe <workspace-name> -p <project_name>

# Describe a workspace workload by UUID
runai workspace describe --uuid=<workspace_uuid>

# Describe a workspace workload with specific output format
runai workspace describe <workspace-name> -o json

# Describe a workspace workload with specific sections
runai workspace describe <workspace-name> --general --compute --pods --events --networks

# Describe a workspace workload with container details and custom limits
runai workspace describe <workspace-name> --containers --pod-limit 20 --event-limit 100
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

* [runai workspace](runai_workspace.md)	 - workspace management

