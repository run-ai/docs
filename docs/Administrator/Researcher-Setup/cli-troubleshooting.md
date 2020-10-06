## When running the CLI you get an error an invalid configuration error

When running any CLI command you get:

    FATA[0000] invalid configuration: no configuration has been provided

### Solution

Your machine is not connected to the Kubernetes cluster. Make sure that you have a ~/.kube directory which contains a config file pointing to the Kubernetes cluster

## When running the CLI you get an error: open .../.kube/config.lock: permission denied

When running any CLI command you get a permission denied error.

### Solution

The user running the CLI does not have read permissions to the .kube directory

## When running 'runai logs', the logs are delayed

By default, Python buffers stdout and stderr, which is not flushed in real-time. This may cause logs to appear sometimes minutes after being buffered

### Solution

Set the env var PYTHONUNBUFFERED to any non-empty string or pass -u to Python. e.g. python -u main.py