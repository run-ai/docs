## runai pvc list

List PVC

```
runai pvc list [flags]
```

### Examples

```
# List of PVC by project with table output
runai pvc list -p <project_name>

# List of PVC by project with table JSON output
runai pvc list -p <project_name> --json

# List of PVC by project with YAML  output
runai pvc list -p <project_name> --yaml
```

### Options

```
  -h, --help             help for list
      --json             Output structure JSON
      --no-headers       Output structure table without headers
  -p, --project string   Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
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

* [runai pvc](runai_pvc.md)	 - PVC management

