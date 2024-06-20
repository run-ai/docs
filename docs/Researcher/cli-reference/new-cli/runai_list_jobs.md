## runai list jobs

[Deprecated] list all jobs

```
runai list jobs [flags]
```

### Options

```
  -A, --all-projects     list jobs from all projects
  -h, --help             help for jobs
      --json             Output structure JSON
  -p, --project string   Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
      --table            Output structure table
      --yaml             Output structure YAML
```

### Options inherited from parent commands

```
      --config-file string   config file name; can be set by environment variable RUNAI_CLI_CONFIG_FILE (default "config.json")
      --config-path string   config path; can be set by environment variable RUNAI_CLI_CONFIG_PATH (default "~/.runai/")
  -d, --debug                enable debug mode
  -v, --verbose              enable verbose mode
```

### SEE ALSO

* [runai list](runai_list.md)	 - [Deprecated] display resource list. By default displays the job list

