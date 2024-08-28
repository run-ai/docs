## runai training mpi list

list MPI training

```
runai training mpi list [flags]
```

### Examples

```
# List all MPI training workloads
runai training mpi list -A

# List MPI training workloads with default project
runai training mpi list

# List MPI training workloads in a specific project
runai training mpi list -p <project_name>

# List all MPI training workloads with a specific output format
runai training mpi list -o wide

# List MPI training workloads with pagination
runai training mpi list --limit 20 --offset 40
```

### Options

```
  -A, --all              list jobs from all projects
  -h, --help             help for list
      --json             Output structure JSON
      --limit int32      number of workload in list, (default 50) (default 50)
      --offset int32     offset number of limit, default 0 (first offset)
  -p, --project string   Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
      --status string    filter by workload state
      --table            Output structure table
      --yaml             Output structure YAML
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

* [runai training mpi](runai_training_mpi.md)	 - MPI management

