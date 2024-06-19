## runai training logs

logs management

```
runai training logs <training-name> [flags]
```

### Examples

```
  # Get logs for a training
  runai training logs training-01

  # Get logs for a specific pod in a training
  runai training logs training-01 --pod=training-01-0

  # Get logs for a specific container in a training
  runai training logs training-01 --container=container-01

  # Get the last 100 lines of logs
  runai training logs training-01 --tail=100

  # Get logs with timestamps
  runai training logs training-01 --timestamps

  # Follow the logs
  runai training logs training-01 --follow

  # Get logs for the previous instance of the training
  runai training logs training-01 --previous

  # Limit the logs to 1024 bytes
  runai training logs training-01 --limit-bytes=1024

  # Get logs since the last 5 minutes
  runai training logs training-01 --since=300s

  # Get logs since a specific timestamp
  runai training logs training-01 --since-time=2023-05-30T10:00:00Z

  # Wait up to 30 seconds for training to be ready for logs
  runai training logs training-01 --wait-timeout=30s
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
```

### Options inherited from parent commands

```
      --config-file string   config file name; can be set by environment variable RUNAI_CLI_CONFIG_FILE (default "config.json")
      --config-path string   config path; can be set by environment variable RUNAI_CLI_CONFIG_PATH (default "~/.runai/")
  -d, --debug                enable debug mode
  -v, --verbose              enable verbose mode
```

### SEE ALSO

* [runai training](runai_training.md)	 - training management

