# runai port-forward

## Description

Forward one or more local ports to the selected job or a pod within the job. The forwarding session ends when the selected job terminates or the terminal is interrupted.

### Examples

1. Port forward connections from localhost:8080 (localhost is the default) to <job-name> on port 8090.

    `runai port-forward <job-name> --port 8080:8090`

2. Port forward connections from 192.168.1.23:8080 to <job-name> on port 8080.

    `runai port-forward <job-name> --port 8080 --address 192.168.1.23`

3. Port forward multiple connections from localhost:8080 to <job-name> on port 8090 and localhost:6443 to <job-name> on port 443.

    `runai port-forward <job-name> --port 8080:8090  --port 6443:443`

4. Port forward into a specific pod in a multi-pod job.

    `runai port-forward <job-name> --port 8080:8090 --pod <pod-name>`

### Global flags

`--loglevel <string>`&mdash;Set the logging level. Choose: <debug|info|warn|error> (default "info").

`-p | --project <string>`&mdash;Specify the project name. To change the default project use `runai config project <project name>`.

### Flags

`--address <string> | [local-interface-ip\host] |localhost | 0.0.0.0 [privileged]`&mdash;The listening address of your local machine. (default "localhost").

`-h | --help`&mdash;Help for the command.

`--port`&mdash;forward ports based on one of the following arguments:

  * `<stringArray>`&mdash;a list of port forwarding combinations.

  * `[local-port]:[remote-port]`&mdash;different local and remote ports.

  * `[local-port=remote-port]`&mdash;the same port is used for both local and remote.

`--pod`&mdash;Specify a pod of a running job. To get a list of the pods of a specific job, run the command `runai describe <job-name>`.

`--pod-running-timeout`&mdash;The length of time (like 5s, 2m, or 3h, higher than zero) to wait until the pod is running. Default is 10 minutes.


***Filter based flags***

`--mpi`&mdash;search **only** for mpi jobs.

`--interactive`&mdash;search **only** for interactive jobs.

`--pytorch`&mdash;search **only** for pytorch jobs.

`--tf`&mdash;search **only** for tensorflow jobs.

`--train`&mdash;search **only** for training jobs.
