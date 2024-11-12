## runai describe job

[Deprecated] Display details of a job

```
runai describe job JOB_NAME [flags]
```

### Options

```
  -h, --help             help for job
  -p, --project string   Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
      --type string      The type of the workload (training, workspace)
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

* [runai describe](runai_describe.md)	 - [Deprecated] Display detailed information about resources

