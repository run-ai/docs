# Creating a new environment

Environment, by definition, is associated with a single project or all projects (current and future ones). Associating an environment to all projects requires administrator or researcher manger role.

The first step of creating an environment would be to press the create environment button and to select under which project it resides and to give the environment a meaningful name.

![](img/env-proj-select.png)

## Setting the container image
The creating user needs to state the image URL path as well as when the image is pulled.

![](img/env-image-pull.png)

## Selecting the relevant tools
In a single environment it is possible to add none or as many tools as needed.
Tools vary from:

* Different applications concept such as Code editor IDEs (e.g VS Code), Experiment tracking (e.g. Weight and Biases), visualization tools (e.g. Tensor Board), etc.
* Open source tool (e.g Jupyter notebook) or commercial 3rd party tools (e.g. MATLAB)

It is also possible to select a custom tool if ones are used in the organization.

![](img/env-tools.png)


Per selected tool the type of connection interface and port need to be inserted. However, defaitl values are added atuoamticly.

The supported connection types are:

* External URL - This connection type allows you to connect to your tool either by inserting a custom URL or having one automated for you. Either way the URL should be unique per workspace because many workspaces may use the same environment. If the the URL type was set to custom, the URL will be requested from the datascientisr upon creating the workspace.


* External node port - A NodePort (see also Kubernetes NodePort) exposes your application externally on every host of the cluster, by accessing http://<HOST_IP>:<NODEPORT> (e.g http://203.0.113.20:30556).


![](img/env-tool-connect-type.png)

!!! Note
    Selecting the tools is not sufficient to have them up and running. The container image still needs to support them as well as having a DNS record and certificate for safe connection.


## Configuring the runtime settings

Per environment, the creating user (either data scientist or administrator) is allowed to set the command running in the container. This command will be visible in the workspace creation form, although it won't be editable (e.g. command python). In addition the data scientist can add arguments which can be edited upon creating a workspace using this environment. Same goes for environment variables, which can be added to the environments, but those can be edited in the workspace creation form.


Note: the value of an environment variable can be left empty for the data scientist to fill in upon workplace creation.

Few example:

1. WANDB
2. UID and GID of jupyter
3. Etc.

Also, in the environment, it is possible to set the path to the working directory that will be used as the current directory when the container running the created workload starts.

![](img/env-runtime-settings.png)

It is possible to either use the exact UID and GID defined in the image. However, in many cases it can be with root privileges so it is possible to override it. If SSO exists, the UID and GID to be used will be the ones of the logged datascientist that creates the workspace, otherwise the data scientist creating the workspace will be guided to provide it upon workspace creation form.

![](img/env-uid-override.png)
