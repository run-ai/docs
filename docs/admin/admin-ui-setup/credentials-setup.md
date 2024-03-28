# Credentials

Credentials are used to unlock protected resources such as applications, containers, and other assets.

The *Credentials* manager in the Run:ai environment supports 3 types of credentials:

1. [Docker registry](#docker-registry)
2. [Access key](#access-key)
3. [User name and password](#username-and-password)
<!-- 4. [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret){target=_blank}.
-->

## Secrets

Credentials are built using `Secrets`. A `Secret` is an object that contains a small amount of sensitive data so that you don't need to include confidential data in your application code. When creating a credential you can either [create a new secret](#configuring-credentials) or use an [existing secret](#existing-secrets).

### Existing secrets

An existing secret is a secret that you have created before creating the credential. One way to create a secret is to use the [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret/#working-with-secrets){target=_blank}
creation tool to create a pre-existing secret for the credential. You must `label` these secrets so that they are registered in the Run:ai environment.

The following command makes the secret available to all projects in the cluster.

```console
kubectl label secret -n runai <SECRET_NAME> run.ai/cluster-wide-credentials=true
```

The following command makes the secret available to the entire scope of a department.

```console
kubectl label secret -n runai <SECRET_NAME> run.ai/resource=<credential_type> run.ai/department=<department-id>
```

`credential_type` is one of the following: `password` / `access-key` / `docker-registry`

The following command makes the secret available to a specific project in the cluster.

```console
kubectl label secret -n <NAMESPACE_OF_PROJECT> <SECRET_NAME> run.ai/credentials=true
```

### User-id and password

You can create a credential using a user-id and password. Use the user-id and password of the target resource.

## Configuring Credentials

!!! Important
    To configure *Credentials* you need to make sure `Workspaces` are enabled.
<!-- 2. Target resource user-id and password for creating a secret in the UI.
1. Configured pre-existing secrets with the applicable `label`.
-->
To configure *Credentials*:

1. Press `Credentials` in the left menu.
2. Press `New Credential` and select one from the list.

### `Docker registry`

1. Select a `Scope` for the credential.
2. In the `Credential name` field, enter a name for the credential.
3. In the `Secret` field, choose from `Existing secret` or `New secret`.

      * If you select `Existing secret`, select an unused secret from the drop down.
  
        !!! Note
            Existing secrets can't be used more than once.

      * If you choose `New secret`, enter a username and password.

4. Enter a URL for the docker registry, then press `Create credential` to create the credential.

### `Access key`

1. Select a `Scope` for the credential.
2. In the `Credential name` field, enter a name for the credential.
3. In the `Secret` field, choose from `Existing secret` or `New secret`.

      * If you select `Existing secret`, select an unused secret from the drop down.

        !!! Note
            Existing secrets can't be used more than once.  

      * If you choose `New secret`, enter an access key and access secret.

4. Press `Create credential` to create the credential.

### `Username and password`

1. Select a `Scope` for the credential.
2. In the `Credential name` field, enter a name for the credential.
3. In the `Secret` field, choose from `Existing secret` or `New secret`.

      * If you select `Existing secret`, select an unused secret from the drop down.
  
        !!! Note
            Existing secrets can't be used more than once.

      * If you choose `New secret`, enter a username and password.

4. Press `Create credential` to create the credential.

## Credentials Table

The *Credentials* table contains a column that shows the status of the credential. The following statuses are supported:

| Status |  Description |
| -- | -- |
| **No issues found** | No issues were found when propagating the credential to the configured scope. |
| **Issues found** | Issues were found while propagating the credentials to the configured scope. |
| **Issues found** | The credential could not be created in the cluster. |
| **No status** | Status could not be displayed because the credentials scope is an account. |
| **No Status** | Status could not be displayed because the current version of the cluster is not up to date. |

You can download the Credentials table to a CSV file. Downloading a CSV can provide a snapshot history of your credentials over the course of time, and help with compliance tracking. All the columns that are selected (displayed) in the table will be downloaded to the file.

To download the Credentials table to a CSV:
1. Open *Credentials*.
2. From the *Columns* icon, select the columns you would like to have displayed in the table.
3. Click on the ellipsis labeled *More*, and download the CSV.
