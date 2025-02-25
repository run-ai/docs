## runai training xgboost exec

execute a command in a xgboost training job

```
runai training xgboost exec [WORKLOAD_NAME] [flags]
```

### Examples

```
# Execute bash in the xgboost training's main worker
runai training xgboost exec xgboost-01 --tty --stdin -- /bin/bash 

# Execute ls command in the xgboost training's main worker
runai training xgboost exec xgboost-01 -- ls

# Execute a command in a specific xgboost training worker
runai training xgboost exec xgboost-01 --pod xgboost-01-worker-1 -- nvidia-smi
```

### Options

```
  -c, --container string               Container name for log extraction
  -h, --help                           help for exec
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

* [runai training xgboost](runai_training_xgboost.md)	 - xgboost management

