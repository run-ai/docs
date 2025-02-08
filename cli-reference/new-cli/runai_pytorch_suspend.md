## runai pytorch suspend

suspend pytorch training

```
runai pytorch suspend [WORKLOAD_NAME] [flags]
```

### Examples

```
# Suspend a pytorch training workload
runai training pytorch suspend <pytorch-name>

# Suspend a pytorch training workload in a specific project
runai training pytorch suspend <pytorch-name> -p <project_name>

# Suspend a pytorch training workload by UUID
runai training pytorch suspend --uuid=<pytorch_uuid>
```

### Options

```
  -h, --help             help for suspend
  -p, --project string   Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
  -u, --uuid string      The UUID of the workload
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

* [runai pytorch](runai_pytorch.md)	 - alias for pytorch management

