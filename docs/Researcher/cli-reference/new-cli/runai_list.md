## runai list

[Deprecated] display resource list. By default displays the job list

```
runai list [flags]
```

### Options

```
  -A, --all-projects     list jobs from all projects
  -h, --help             help for list
  -p, --project string   Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
```

### Options inherited from parent commands

```
      --config-file string   config file name; can be set by environment variable RUNAI_CLI_CONFIG_FILE (default "config.json")
      --config-path string   config path; can be set by environment variable RUNAI_CLI_CONFIG_PATH (default "~/.runai/")
  -d, --debug                enable debug mode
  -v, --verbose              enable verbose mode
```

### SEE ALSO

* [runai](runai.md)	 - Run:ai Command-line Interface
* [runai list clusters](runai_list_clusters.md)	 - [Deprecated] list all available clusters
* [runai list jobs](runai_list_jobs.md)	 - [Deprecated] list all jobs
* [runai list nodes](runai_list_nodes.md)	 - [Deprecated] list all nodes
* [runai list projects](runai_list_projects.md)	 - [Deprecated] list all available projects

