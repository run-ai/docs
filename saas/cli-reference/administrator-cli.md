# Administrator CLI

The Run:ai Administrator (`runai-adm`) is a lightweight tool designed to support infrastructure administrators by simplifying two key tasks:

* [Collecting logs](../infrastructure-procedures/logs-collection.md) for troubleshooting and sharing with Run:ai support.
* Configuring [node roles](../advanced-setup/node-roles.md) in the cluster for optimal performance and reliability.

This article outlines the installation and usage of the Run:ai Administrator CLI to help you get started quickly.

### Prerequisites

Before installing the CLI, review the following:

* **Operating system**: The CLI is supported on Mac and Linux.
* **Kubectl**: The Kubernetes command-line interface must be installed and configured to access your cluster. Follow the [official guide](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
* **Cluster administrative permissions**: The CLI requires a Kubernetes profile with administrative privileges.

### Installation

To install the Run:ai Administrator CLI, ensure that the CLI version matches the version of your Run:ai cluster. You can either install the latest version or a specific version from the [list](https://runai.jfrog.io/ui/native/cli/runai-admin-cli/).

#### Installing the latest version

Use the following commands to download and install the latest version of the CLI:

<details>

<summary><strong>Mac</strong></summary>

```bash
wget --content-disposition https://app.run.ai/v1/k8s/admin-cli/darwin  
chmod +x runai-adm  
sudo mv runai-adm /usr/local/bin/runai-adm
```

</details>

<details>

<summary><strong>Linux</strong></summary>

```bash
wget --content-disposition https://app.run.ai/v1/k8s/admin-cli/linux  
chmod +x runai-adm  
sudo mv runai-adm /usr/local/bin/runai-adm
```

</details>

#### Installing a specific version

To install a specific version of the Administrator CLI that matches your Run:ai cluster version, append the version number to the download URL. Refer to the list of available versions linked above for the correct version number.

<details>

<summary><strong>Mac</strong></summary>

```bash
wget --content-disposition https://app.run.ai/v1/k8s/admin-cli/<version>/darwin # Replace <version> with the desired version in the format vX.X.X (e.g., v2.19.5) 
chmod +x runai-adm  
sudo mv runai-adm /usr/local/bin/runai-adm
```

</details>

<details>

<summary><strong>Linux</strong></summary>

```bash
wget --content-disposition https://app.run.ai/v1/k8s/admin-cli/<version>/linux # Replace <version> with the desired version in the format vX.X.X (e.g., v2.19.5)
chmod +x runai-adm  
sudo mv runai-adm /usr/local/bin/runai-adm
```

</details>

#### Verifying installation

Verify your installation completed successfully by running the following command:

```sh
runai-adm version  
```

### Reference

#### Node roles

To set or remove node rules using the `runai-adm` tool, run the following:

```sh
runai-adm set node-role [--runai-system-worker | --gpu-worker | --cpu-worker] <node-name>
```

```sh
runai-adm remove node-role [--runai-system-worker | --gpu-worker | --cpu-worker] <node-name>
```

{% hint style="info" %}
Use the `--all` flag to set or remove a role to all nodes.
{% endhint %}

#### Collect logs

To collect logs using the `runai-adm` tool:

1.  Run the following command:

    ```sh
    runai-adm collect-logs
    ```
2. Locate the generated compressed log file.
