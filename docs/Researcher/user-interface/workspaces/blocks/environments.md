
# Environment introduction


The _environment_ block consists of the URL path for the container image and the image pull policy. It exposes all the necessary tools (open source, 3rd party, or custom tools) along with their connection interfaces  (See also [External URL](#xxx), [External node port](#xxx) and the container ports.

An environment is a __mandatory__ building block for the creation of a workspace. 

![](images/env-tools.png)

You can also include commands, arguments, and environment variables, as well as the user identity with permission to run the commands in the container.

!!! Note
    Additional arguments and environment variables can be added to workspaces even if they were not defined in the environment used by the workspace. This ensures that the same environment can still serve many workspaces, even if they differ by their arguments and environment variables.

## See Also

* Create an [Environment](../create/create-env.md)). 