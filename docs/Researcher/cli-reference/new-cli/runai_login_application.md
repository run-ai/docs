## runai login application

login as an application

```
runai login application [flags]
```

### Examples

```
  
  # Login interactive using application credentials
  runai login app

  # Login using application credentials
  login app --name=<app_name> --secret=<app_secret> --interactive=disabled

  # Login and Save application credentials
  login app --name=<app_name> --secret=<app_secret> --interactive=disabled --save

```

### Options

```
  -h, --help                 help for application
      --interactive enable   set interactive mode (enabled|disabled)
      --name string          application name
      --save                 save application credentials in config file
      --secret string        application secret
      --secret-file string   use application secret from file
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

* [runai login](runai_login.md)	 - login to the control plane

