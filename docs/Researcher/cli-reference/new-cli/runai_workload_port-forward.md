## runai workload port-forward

port forward management

```
runai workload port-forward WORKLOAD_NAME [flags]
```

### Examples

```
# Forward connections from localhost:8080 to <workload-name> on port 8090:
runai workload port-forward <workload-name> --type=<workload-type> --port 8080:8090 --address localhost

# Forward connections from 0.0.0.0:8080 to <job-name> on port 8080:
runai workload port-forward <workload-name> --type=<workload-type> --port 8080 --address 0.0.0.0 [requires privileges]

# Forward multiple connections from localhost:8080 to <workload-name> on port 8090 and from localhost:6443 to <workload-name> on port 443:
runai workload port-forward <workload-name> --type=<workload-type> --port 8080:8090 --port 6443:443 --address localhost
```

### Options

```
      --address string                 --address [local-interface-ip\host] --address localhost --address 0.0.0.0 [privileged] (default "localhost")
  -h, --help                           help for port-forward
      --pod string                     Workload pod ID for port-forward, default: distributed(master) otherwise(random)
      --pod-running-timeout duration   Pod check for running state timeout.
      --port stringArray               port
  -p, --project string                 Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
      --type string                    The type of the workload (training, workspace)
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

