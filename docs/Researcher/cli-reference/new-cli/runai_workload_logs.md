## runai workload logs

logs management

```
runai workload logs <workload-name> [flags]
```

### Examples

```
  # Get logs for a workspace
  runai workload logs workspace-01 --workload-type=workspace

  # Get logs for a specific pod in a workspace
  runai workload logs workspace-01 --workload-type=workspace --pod=workspace-01-0

  # Get logs for a specific container in a workspace
  runai workload logs workspace-01 --workload-type=workspace --container=container-01

  # Get the last 100 lines of logs
  runai workload logs workspace-01 --workload-type=workspace --tail=100

  # Get logs with timestamps
  runai workload logs workspace-01 --workload-type=workspace --timestamps

  # Follow the logs
  runai workload logs workspace-01 --workload-type=workspace --follow

  # Get logs for the previous instance of the workspace
  runai workload logs workspace-01 --workload-type=workspace --previous

  # Limit the logs to 1024 bytes
  runai workload logs workspace-01 --workload-type=workspace --limit-bytes=1024

  # Get logs since the last 5 minutes
  runai workload logs workspace-01 --workload-type=workspace --since=5m

  # Get logs since a specific timestamp
  runai workload logs workspace-01 --workload-type=workspace --since-time=2023-05-30T10:00:00Z

  # Wait up to 30 seconds for workload to be ready for logs
  runai workload logs workspace-01 --workload-type=workspace --wait-timeout=30s
```

### Options

```
  -c, --container string        Container name for log extraction
  -f, --follow                  Follow log output
  -h, --help                    help for logs
      --limit-bytes int         Limit the number of bytes returned from the server
      --pod string              Job pod ID for log extraction, default: master (0-0)
      --previous                Show previous pod log output
  -p, --project string          Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
      --since duration          Return logs newer than a relative duration like 5s, 2m, or 3h. Defaults to all logs
      --since-time string       Return logs after a specific date (RFC3339)
      --tail int                Numer of tailed lines to fetch from the log, for no limit set to -1 (default -1)
      --timestamps              Show timestamps in log output
      --wait-timeout duration   Timeout for waiting for workload to be ready for log streaming
      --workload-name string    Set job name for log extraction
  -t, --workload-type string    The type of the workload (training, workspace, distributed)
```

### Options inherited from parent commands

```
      --config-file string   config file name; can be set by environment variable RUNAI_CLI_CONFIG_FILE (default "config.json")
      --config-path string   config path; can be set by environment variable RUNAI_CLI_CONFIG_PATH (default "~/.runai/")
  -d, --debug                enable debug mode
  -v, --verbose              enable verbose mode
```

### SEE ALSO

* [runai workload](runai_workload.md)	 - workload management

