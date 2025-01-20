## runai

Run:ai Command-line Interface

### Synopsis

runai - The Run:ai Researcher Command Line Interface
	
Description:  
  A tool for managing Run:ai workloads and monitoring available resources.
  It provides researchers with comprehensive control over their AI development environment.


```
runai [flags]
```

### Options

```
      --config-file string   config file name; can be set by environment variable RUNAI_CLI_CONFIG_FILE (default "config.json")
      --config-path string   config path; can be set by environment variable RUNAI_CLI_CONFIG_PATH (default "~/.runai/")
  -d, --debug                enable debug mode
  -h, --help                 help for runai
  -q, --quiet                enable quiet mode, suppress all output except error messages
      --verbose              enable verbose mode
```

### SEE ALSO

* [runai cluster](runai_cluster.md)	 - cluster management
* [runai config](runai_config.md)	 - configuration management
* [runai kubeconfig](runai_kubeconfig.md)	 - kubeconfig management
* [runai describe](runai_describe.md)	 - [Deprecated] Display detailed information about resources
* [runai distributed](runai_distributed.md)	 - distributed management
* [runai exec](runai_exec.md)	 - [Deprecated] exec
* [runai list](runai_list.md)	 - [Deprecated] display resource list. By default displays the job list
* [runai login](runai_login.md)	 - login to the control plane
* [runai logout](runai_logout.md)	 - logout from control plane
* [runai logs](runai_logs.md)	 - [Deprecated] logs
* [runai node](runai_node.md)	 - node management
* [runai nodepool](runai_nodepool.md)	 - node pool management
* [runai port-forward](runai_port-forward.md)	 - [Deprecated] port forward
* [runai project](runai_project.md)	 - project management
* [runai report](runai_report.md)	 - [Experimental] report management
* [runai submit](runai_submit.md)	 - [Deprecated] Submit a new workload
* [runai training](runai_training.md)	 - training management
* [runai upgrade](runai_upgrade.md)	 - upgrades the CLI to the latest version
* [runai version](runai_version.md)	 - show the current version of the CLI
* [runai whoami](runai_whoami.md)	 - show the current logged in user
* [runai workload](runai_workload.md)	 - workload management
* [runai workspace](runai_workspace.md)	 - workspace management

