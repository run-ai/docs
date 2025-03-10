## runai inference update

update inference

```
runai inference update [WORKLOAD_NAME] [flags]
```

### Examples

```
# Update a inference workload with a new image
runai inference update <name> -p <project_name> -i runai.jfrog.io/demo/quickstart-demo

# Update a inference workload with a new autoscaling configuration
runai inference update <name> -p <project_name> --max-replicas=5 --min-replicas=3 --metric=latency --metric-threshold=10

```

### Options

```
      --activation-replicas int32               The number of replicas to run when scaling-up from zero. Defaults to minReplicas, or to 1 if minReplicas is set to 0
  -c, --command                                 If true, override the image's entrypoint with the command supplied after '--'
      --concurrency-hard-limit int32            The maximum number of requests allowed to flow to a single replica at any time. 0 means no limit
      --create-home-dir                         Create a temporary home directory. Defaults to true when --run-as-user is set, false otherwise
  -e, --environment stringArray                 Set environment variables in the container
  -h, --help                                    help for update
  -i, --image string                            The image for the workload
      --image-pull-policy string                Set image pull policy. One of: Always, IfNotPresent, Never. Defaults to Always (default "Always")
      --initial-replicas int32                  The number of replicas to run when initializing the workload for the first time. Defaults to minReplicas, or to 1 if minReplicas is set to 0
      --initialization-timeout-seconds int32    The maximum amount of time (in seconds) to wait for the container to become ready
      --max-replicas int32                      The maximum number of replicas for autoscaling. Defaults to minReplicas, or to 1 if minReplicas is set to 0
      --metric string                           Autoscaling metric is required if minReplicas < maxReplicas, except when minReplicas = 0 and maxReplicas = 1. Use 'throughput', 'concurrency', 'latency', or custom metrics.
      --metric-threshold int32                  The threshold to use with the specified metric for autoscaling. Mandatory if metric is specified
      --metric-threshold-percentage float32     The percentage of metric threshold value to use for autoscaling. Defaults to 70. Applicable only with the 'throughput' and 'concurrency' metrics
      --min-replicas int32                      The minimum number of replicas for autoscaling. Defaults to 1. Use 0 to allow scale-to-zero
  -p, --project string                          Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
      --scale-down-delay-seconds int32          The minimum amount of time (in seconds) that a replica will remain active after a scale-down decision
      --scale-to-zero-retention-seconds int32   The minimum amount of time (in seconds) that the last replica will remain active after a scale-to-zero decision. Defaults to 0. Available only if minReplicas is set to 0
      --working-dir string                      Set the container's working directory
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

