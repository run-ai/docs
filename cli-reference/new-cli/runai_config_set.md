## runai config set

Set configuration values

```
runai config set [flags]
```

### Examples

```
runai config set --status-timeout-duration 5s
runai config set --status-timeout-duration 300ms
```

### Options

```
      --auth-url string                  set the authorization URL; most likely the same as the control plane URL
      --cp-url string                    set the control plane URL
  -h, --help                             help for set
      --interactive enable               set interactive mode (enabled|disabled)
      --output string                    set the default output type
      --status-timeout-duration string   set cluster status call timeout duration value, the default is 3 second ("3s")
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

* [runai config](runai_config.md)	 - configuration management

