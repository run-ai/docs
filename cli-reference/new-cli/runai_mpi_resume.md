## runai mpi resume

resume mpi training

```
runai mpi resume [WORKLOAD_NAME] [flags]
```

### Examples

```
# Resume a mpi training workload
runai training mpi resume <mpi-name>

# Resume a mpi training workload in a specific project
runai training mpi resume <mpi-name> -p <project_name>

# Resume a mpi training workload by UUID
runai training mpi resume --uuid=<mpi_uuid>
```

### Options

```
  -h, --help             help for resume
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

* [runai mpi](runai_mpi.md)	 - alias for mpi management

