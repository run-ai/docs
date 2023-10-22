# Creating a new environment

To create an environment:

1. In the left menu, press *New Environment*.
2. In the *Scope* pane, choose one item from the tree. The compute resource is assigned to that item and all its subsidiaries.
3. Enter an *Environment name*.
4. Enter the image URL path and an image pull policy.
5. Choose a supported workload type. Configure this section based on the type of workload you expect to run in this environment. Choose from:

      * `Single node`&mdash;use for running workloads on a single node.
      * `Mult-node`&mdash;use for running distributed workloads on multiple nodes.

    Then choose the workload that can use the environment:

      * `Workspace`
      * `Training`

6. Select a tool from the list. You can add multiple tools by pressing *+ Tool+. Selecting a tool is optional.

    Tools can be:

      * Different applications such as Code editor IDEs (for example, VS Code), Experiment tracking (for example,. Weight and Biases), visualization tools (for example,. Tensor Board), and more.
      * Open source tools (for example, Jupyter notebook) or commercial 3rd party tools (for example,. MATLAB)

    It is also possible to set up a custom tool used by the organization.

    For each tool, you must set the type of connection interface and port. If not set, default values are provided. The supported connection types are:

      * External URL:  This connection type allows you to connect to your tool either by inserting a custom URL or having one generated for you. Either way, the URL should be unique per workspace as many workspaces may use the same environment. If the URL type was set to custom, the URL will be requested from the Researcher upon creating the workspace.
      * External node port: A [NodePort](../../../../admin/runai-setup/config/allow-external-access-to-containers.md) exposes your application externally on every host of the cluster, access the tool using `http://<HOST_IP>:<NODEPORT>` (for example, http://203.0.113.20:30556).

    !!! Note
        Selecting a tool requires configuration to be up and running. To configure a tool:

    * The container image needs to support the tool. 
    * The administrator must configure a DNS record and certificate. For more information, see [Workspaces configuration](../../../../admin/runai-setup/config/allow-external-access-to-containers.md#workspaces-configuration).

7. Configure runtime settings with:

       1. Commands and arguments&mdash;visible, but not editable in the workspace creation form.
       2. Environment variables&mdash;visible and editable in the workspace creation form.
       3. Set the container's working directory.

    !!! Note
        The value of an environment variable can remain empty for the researcher to fill in when creating a workspace.

8. Configure the security settings from:

       1. Settings in the image&mdash;security settings that come with the image file. 
       2. Custom settings:
   
            1. User ID.
            2. Group ID.
            3. Supplementary Groups.
            4. Values modification settings.
    
       3. Add linux capabilities.
