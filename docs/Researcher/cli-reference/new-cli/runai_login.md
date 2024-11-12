## runai login

login to the control plane

```
runai login [flags]
```

### Examples

```

  # Login using browser
  runai login

  # Login using SSO without browser
  runai login sso

  # Login using username and password without browser
  runai login user -u <username> 

  # Login using browser with specific port and host
  runai login --listen-port=43121 --listen-host=localhost

```

### Options

```
  -h, --help                 help for login
      --listen-host string   the host to listen on for the authentication callback (for browser mode only) (default "localhost")
      --listen-port int      the port to listen on for the authentication callback (for browser mode only) (default 43121)
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

* [runai](runai.md)	 - Run:ai Command-line Interface
* [runai login application](runai_login_application.md)	 - login as an application
* [runai login sso](runai_login_sso.md)	 - login using sso without browser
* [runai login user](runai_login_user.md)	 - login for local user without browser

