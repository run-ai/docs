## runai workload exec

exec management

```
runai workload exec WORKLOAD_NAME [flags]
```

### Examples

```
# Execute bush to workspace 
runai workload exec jup --type workspace --tty --stdin -- /bin/bash 

# Execute ls to workload
runai workload exec jup --type workspace -- ls
```

### Options

```
  -c, --container string               Container name for log extraction
  -h, --help                           help for exec
      --pod string                     Workload pod ID for log extraction, default: master (0-0)
      --pod-running-timeout duration   Pod check for running state timeout
  -p, --project string                 Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
      --stdin                          Pass stdin to the container
      --tty                            Stdin is a TTY
      --type string                    The type of the workload (training, workspace, distributed)
      --wait-timeout duration          Timeout for waiting for workload to be ready for log streaming
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

* [runai workload](runai_workload.md)	 - workload management

