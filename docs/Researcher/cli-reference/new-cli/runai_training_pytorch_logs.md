## runai training pytorch logs

view logs of a pytorch training job

```
runai training pytorch logs [WORKLOAD_NAME] [flags]
```

### Examples

```
# Get logs for a pytorch training
runai training pytorch logs pytorch-01

# Get logs for a specific pod in a pytorch training
runai training pytorch logs pytorch-01 --pod=pytorch-01-worker-0

# Get logs for a specific container in a pytorch training
runai training pytorch logs pytorch-01 --container=pytorch-worker

# Get the last 100 lines of logs
runai training pytorch logs pytorch-01 --tail=100

# Get logs with timestamps
runai training pytorch logs pytorch-01 --timestamps

# Follow the logs
runai training pytorch logs pytorch-01 --follow

# Get logs for the previous instance of the pytorch training
runai training pytorch logs pytorch-01 --previous

# Limit the logs to 1024 bytes
runai training pytorch logs pytorch-01 --limit-bytes=1024

# Get logs since the last 5 minutes
runai training pytorch logs pytorch-01 --since=300s

# Get logs since a specific timestamp
runai training pytorch logs pytorch-01 --since-time=2023-05-30T10:00:00Z

# Wait up to 30 seconds for pytorch training to be ready for logs
runai training pytorch logs pytorch-01 --wait-timeout=30s
```

### Options

```
  -c, --container string        Container name for log extraction
  -f, --follow                  Follow log output
  -h, --help                    help for logs
      --limit-bytes int         Limit the number of bytes returned from the server
      --name string             Set workload name for log extraction
      --pod string              Workload pod ID for log extraction, default: master (0-0)
      --previous                Show previous pod log output
  -p, --project string          Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
      --since duration          Return logs newer than a relative duration like 5s, 2m, or 3h. Defaults to all logs
      --since-time string       Return logs after a specific date (RFC3339)
  -t, --tail int                Numer of tailed lines to fetch from the log, for no limit set to -1 (default -1)
      --timestamps              Show timestamps in log output
      --wait-timeout duration   Timeout for waiting for workload to be ready for log streaming
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

* [runai training pytorch](runai_training_pytorch.md)	 - pytorch management

