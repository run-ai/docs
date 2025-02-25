## runai workspace list

list workspace

```
runai workspace list [flags]
```

### Examples

```
# List all workspace workloads
runai workspace list -A

# List workspace workloads with default project
runai workspace list

# List workspace workloads in a specific project
runai workspace list -p <project_name>

# List all workspace workloads with a specific output format
runai workspace list -o wide

# List workspace workloads with pagination
runai workspace list --limit 20 --offset 40
```

### Options

```
  -A, --all              list workloads from all projects
  -h, --help             help for list
      --json             Output structure JSON
      --limit int32      number of workload in list (default 50)
      --no-headers       Output structure table without headers
      --offset int32     offset number of limit, default 0 (first offset)
  -p, --project string   Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
      --status string    filter by workload state
      --table            Output structure table
      --yaml             Output structure YAML
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

* [runai workspace](runai_workspace.md)	 - workspace management

