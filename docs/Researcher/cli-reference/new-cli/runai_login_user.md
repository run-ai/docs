## runai login user

login for local user without browser

### Synopsis

Login to the control plane using a local user without browser

```
runai login user [flags]
```

### Examples

```

  # Login using user credentials without browser
  runai login user --user=<user> --password=<password>

```

### Options

```
  -h, --help              help for user
  -p, --password string   the password of the given username
  -u, --user string       the username to login with
```

### Options inherited from parent commands

```
      --config-file string   config file name; can be set by environment variable RUNAI_CLI_CONFIG_FILE (default "config.json")
      --config-path string   config path; can be set by environment variable RUNAI_CLI_CONFIG_PATH (default "~/.runai/")
  -d, --debug                enable debug mode
  -v, --verbose              enable verbose mode
```

### SEE ALSO

* [runai login](runai_login.md)	 - login to the control plane

