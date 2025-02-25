## runai workspace delete

delete workspace workload

```
runai workspace delete [WORKLOAD_NAME] [flags]
```

### Examples

```
# Delete a workspace workload with a default project
runai workspace delete <workspace-name>

# Delete a workspace workload with a specific project
runai workspace delete <workspace-name> -p <project_name>

# Delete a workspace workload by UUID
runai workspace delete --uuid=<workspace_uuid> -p <project_name>
```

### Options

```
  -h, --help             help for delete
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

* [runai workspace](runai_workspace.md)	 - workspace management

