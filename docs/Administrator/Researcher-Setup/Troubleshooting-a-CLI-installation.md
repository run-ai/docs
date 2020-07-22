### When running the CLI you get an error an invalid configuration error

When running any CLI command you get:

    FATA[0000] invalid configuration: no configuration has been provided

#### Solution

Your machine is not connected to the Kubernetes cluster. Make sure that you have a ~/.kube directory which contains a config file pointing to the Kubernetes cluster

### When running the CLI you get an error: open .../.kube/config.lock: permission denied

When running any CLI command you get a permission denied error.

#### Solution

The user running the CLI does not have read permissions to the .kube directory