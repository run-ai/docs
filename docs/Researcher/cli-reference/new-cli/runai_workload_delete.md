## runai workload delete

Delete workloads

```
runai workload delete [flags]
```

### Examples

```
# Delete multiple workloads
runai delete -p proj1 workload01 workload02 workload03

# Delete list of workloads with PyTorch framework filter
runai delete -p proj1 --framework pytorch workload01 workload02 workload03

# Delete list of workloads with training type filter
runai delete -p proj1 --type training workload01 workload02 workload03

# Delete multiple workloads by bypassing confirmation
runai delete -p proj1 -y workload01 workload02 workload03
```

### Options

```
      --framework string   filter by workload framework
  -h, --help               help for delete
  -p, --project string     Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
      --type string        filter by workload type
  -y, --yes                bypass confirmation dialog by answering yes
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

* [runai workload](runai_workload.md)	 - workload management

