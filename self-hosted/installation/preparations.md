---
title: Self Hosted installation over Kubernetes - preparations
---

# Preparations

The following section provides the information needed to prepare for a Run:ai installation. Before you start, make sure to follow the [system requirements](prerequisites.md).

## Software artifacts

### Kubernetes

<details>

<summary>Connected</summary>

You should receive a file: `runai-reg-creds.yaml` from Run:ai Customer Support. The file provides access to the Run:ai Container registry.

SSH into a node with `kubectl` access to the cluster and `Docker` installed. Run the following to enable image download from the Run:ai Container Registry on Google cloud:

<pre class="language-bash"><code class="lang-bash"><strong>kubectl create namespace runai-backend
</strong>kubectl apply -f runai-reg-creds.yaml
</code></pre>

</details>

<details>

<summary>Airgapped</summary>

You should receive a single file `runai-air-gapped-<VERSION>.tar.gz` from Run:ai customer support

SSH into a node with `kubectl` access to the cluster and `Docker` installed.

Run:ai assumes the existence of a Docker registry for images. Most likely installed within the organization. The installation requires the network address and port for the registry (referenced below as `<REGISTRY_URL>`).

To extract Run:ai files, replace `<VERSION>` in the command below and run:

```bash
tar xvf runai-airgapped-package-<VERSION>.tar.gz
kubectl create namespace runai-backend
```

**Upload images**

Upload images to a local Docker Registry. Set the Docker Registry address in the form of `NAME:PORT` (do not add `https`):

```bash
export REGISTRY_URL=<Docker Registry address>
```

Run the following script (you must have at least 20GB of free disk space to run):

```bash
./setup.sh
```

(If docker is configured to [run as non-root](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user) then `sudo` is not required).

The script should create a file named `custom-env.yaml` which will be used by the control-plane installation.

</details>

### OpenShift

<details>

<summary>Connected</summary>

You should receive a file: `runai-reg-creds.yaml` from Run:ai Customer Support. The file provides access to the Run:ai Container registry.

SSH into a node with `oc` access (`oc` is the OpenShift command line) to the cluster and `Docker` installed.

Run the following to enable image download from the Run:ai Container Registry on Google cloud:

```bash
oc apply -f runai-reg-creds.yaml -n runai-backend
```

</details>

<details>

<summary>Airgapped</summary>

You should receive a single file `runai-<version>.tar` from Run:ai customer support

Run:ai assumes the existence of a Docker registry for images. Most likely installed within the organization. The installation requires the network address and port for the registry (referenced below as `<REGISTRY_URL>`).

SSH into a node with `oc` access (`oc` is the OpenShift command line) to the cluster and `Docker` installed.

To extract Run:ai files, replace `<VERSION>` in the command below and run:

```
tar xvf runai-airgapped-package-<VERSION>.tar.gz
```

**Upload images**

Upload images to a local Docker Registry. Set the Docker Registry address in the form of `NAME:PORT` (do not add `https`):

```bash
export REGISTRY_URL=<Docker Registry address>
```

Run the following script (you must have at least 20GB of free disk space to run):

```bash
./setup.sh
```

(If docker is configured to [run as non-root](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user) then `sudo` is not required).

The script should create a file named custom-env.yaml which will be used by the control-plane installation.

</details>

### Private Docker Registry (optional)

<details>

<summary>Kubernetes</summary>

To access the organization's docker registry it is required to set the registry's credentials (imagePullSecret)

Create the secret named `runai-reg-creds` based on your existing credentials. For more information, see [Pull an Image from a Private Registry](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/).

</details>

<details>

<summary>OpenShift</summary>

To access the organization's docker registry it is required to set the registry's credentials (imagePullSecret)

Create the secret named `runai-reg-creds` in the `runai-backend` namespace based on your existing credentials. The configuration will be copied over to the `runai` namespace at cluster install. For more information, see [Allowing pods to reference images from other secured registries](https://docs.openshift.com/container-platform/latest/openshift_images/managing_images/using-image-pull-secrets.html#images-allow-pods-to-reference-images-from-secure-registries_using-image-pull-secrets).&#x20;

</details>

## Configure your environment

### External Postgres database (optional)

If you have opted to use an [external PostgreSQL database](prerequisites.md#external-postgres-database-optional), you need to perform initial setup to ensure successful installation. Follow these steps:

1.  Create a SQL script file, edit the parameters below, and save it locally:

    * Replace `<DATABASE_NAME>` with a dedicate database name for RunAi in your PostgreSQL database.
    * Replace `<ROLE_NAME>` with a dedicated role name (user) for RunAi database.
    * Replace `<ROLE_PASSWORD>` with a password for the new PostgreSQL role.
    * Replace `<GRAFANA_PASSWORD>` with the password to be set for Grafana integration.

    ```sql
    -- Create a new database for runai
    CREATE DATABASE <DATABASE_NAME>; 

    -- Create the role with login and password
    CREATE ROLE <ROLE_NAME>  WITH LOGIN PASSWORD '<ROLE_PASSWORD>'; 

    -- Grant all privileges on the database to the role
    GRANT ALL PRIVILEGES ON DATABASE <DATABASE_NAME> TO <ROLE_NAME>; 

    -- Connect to the newly created database
    \c <DATABASE_NAME> 

    -- grafana
    CREATE ROLE grafana WITH LOGIN PASSWORD '<GRAFANA_PASSWORD>'; 
    CREATE SCHEMA grafana authorization grafana;
    ALTER USER grafana set search_path='grafana';
    -- Exit psql
    \q
    ```
2.  Run the following command on a machine where PostgreSQL client (`pgsql`) is installed:

    * Replace `<POSTGRESQL_HOST>` with the PostgreSQL ip address or hostname.
    * Replace `<POSTGRESQL_USER>` with the PostgreSQL username.
    * Replace `<POSTGRESQL_PORT>` with the port number where PostgreSQL is running.
    * Replace `<POSTGRESQL_DB>` with the name of your PostgreSQL database.
    * Replace `<POSTGRESQL_DB>` with the name of your PostgreSQL database.
    * Replace `<SQL_FILE>` with the path to the SQL script created in the previous step. TBD: not in openshift

    ```bash
    psql --host <POSTGRESQL_HOST> \ # (1)
    --user <POSTGRESQL_USER> \ # (2)
    --port <POSTGRESQL_PORT> \ # (3)
    --dbname <POSTGRESQL_DB> \ # (4)
    -a -f <SQL_FILE> \ # (5)
    ```
