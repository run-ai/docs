

This article provides instructions for IT administrators on collecting Run:ai logs for support, including prerequisites, CLI commands, and log file retrieval. It also covers enabling verbose logging for Prometheus and the Run:ai Scheduler.

## Collect logs to send to support

To collect Run:ai logs, follow these steps precisely:

### Prerequisites

* Ensure that you have administrator-level access to the Kubernetes cluster where Run:ai is installed.  
* The Run:ai Administrator Command-Line Interface (CLI) must be [installed](..//config/cli-admin-install.md).  
* You must be logged into the Run:ai CLI with the correct permissions.

### Step-by-Step Instructions

1. Open a terminal on your local machine (or any machine that has network access to the Kubernetes cluster) where the Run:ai Administrator CLI is installed.  
2. Log in to the Run:ai CLI (if required)  
3. Collect the Logs: 
    Execute the command to collect the logs:  

    ``` bash
    runai-adm collect-logs
    ```

    This command gathers all relevant Run:ai logs from the system and generate a compressed file.

5. Locate the Generated File  
   After running the command, note the location of the generated compressed log file. You can retrieve and send this file to Run:ai Support for further troubleshooting.

!!! Note
    The tar file packages the logs of Run:ai components only. It does __not__ include logs of researcher containers that may contain private information. 

## Logs verbosity

Increase log verbosity to capture more detailed information, providing deeper insights into system behavior and make it easier to identify and resolve issues.

### Prerequisites

Before you begin, ensure you have the following:

* Access to the Kubernetes cluster where Run:ai is installed  
  * Including necessary permissions to view and modify configurations.  
* kubectl installed and configured:  
  * The Kubernetes command-line tool, `kubectl`, must be installed and configured to interact with the cluster.  
  * Sufficient privileges to edit configurations and view logs.  
* Administrative access to Run:ai’s installation settings.  
* Monitoring Disk Space  
  * When enabling verbose logging, ensure adequate disk space to handle the increased log output, especially when enabling debug or high verbosity levels.

### Adding verbosity

#### Adding verbosity to Prometheus

To increase the logging verbosity for Prometheus, follow these steps:

1. Edit the `RunaiConfig` to adjust Prometheus log levels. Copy the following command to your terminal:  
2. Bash

```
kubectl edit runaiconfig runai -n runai
```

4.   
   In the configuration file that opens, add or modify the following section to set the log level to `debug`:  
5. Bash

```
spec:
  prometheus:
    spec:
      logLevel: debug
```

7.   
   Save the changes. To view the Prometheus logs with the new verbosity level, run:  
8. Bash

```
kubectl logs -n runai prometheus-runai-0
```

10.   
    This command streams the last 100 lines of logs from Prometheus, providing detailed information useful for debugging.

#### Adding verbosity to the scheduler

To enable extended logging for the Run:ai scheduler:

1. Edit the `RunaiConfig` to adjust scheduler verbosity:  
2. Bash

```
kubectl edit runaiconfig runai -n runai
```

4.   
   Add or modify the following section under the scheduler settings:  
5. Bash

```
runai-scheduler:
  args:
    verbosity: 6
```

7.   
   This increases the verbosity level of the scheduler logs to provide more detailed output.

Warning

Enabling verbose logging can significantly increase disk space usage. Monitor your storage capacity and adjust the verbosity level as necessary.

