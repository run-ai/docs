## runai mpi bash

open a bash shell in a mpi training job

```
runai mpi bash [WORKLOAD_NAME] [flags]
```

### Examples

```
# Open a bash shell in the mpi training's main worker
runai training mpi bash mpi-01

# Open a bash shell in a specific mpi training worker
runai training mpi bash mpi-01 --pod mpi-01-worker-1
```

### Options

```
  -c, --container string               Container name for log extraction
  -h, --help                           help for bash
      --pod string                     Workload pod ID for log extraction, default: master (0-0)
      --pod-running-timeout duration   Pod check for running state timeout.
  -p, --project string                 Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
  -i, --stdin                          Pass stdin to the container
  -t, --tty                            Stdin is a TTY
      --wait-timeout duration          Timeout for waiting for workload to be ready for log streaming
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

* [runai mpi](runai_mpi.md)	 - alias for mpi management

