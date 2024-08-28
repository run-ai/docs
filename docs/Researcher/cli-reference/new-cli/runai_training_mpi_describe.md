## runai training mpi describe

describe MPI training

```
runai training mpi describe [WORKLOAD_NAME] [flags]
```

### Examples

```
# Describe an MPI training workload with a default project
runai training mpi describe <training-mpi-name>

# Describe an MPI training workload in a specific project
runai training mpi describe <training-mpi-name> -p <project_name>

# Describe an MPI training workload by UUID
runai training mpi describe --uuid=<training_mpi_uuid>

# Describe an MPI training workload with specific output format
runai training mpi describe <training-mpi-name> -o json

# Describe an MPI training workload with specific sections
runai training mpi describe <training-mpi-name> --general --compute --pods --events --networks

# Describe an MPI training workload with container details and custom limits
runai training mpi describe <training-mpi-name> --containers --pod-limit 20 --event-limit 100
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

* [runai training mpi](runai_training_mpi.md)	 - MPI management

