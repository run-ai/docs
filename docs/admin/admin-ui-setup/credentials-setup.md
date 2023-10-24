# Credentials

Credentials are used to unlock protected resources such as applications, containers, and other assets.

The *Credentials* manager in the Run:ai environment supports 4 types of credentials:

1. Docker registry.
2. Access key.
3. User name and password.
<!-- 4. [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret){target=_blank}.
-->

## Secrets

Credentials are built using `Secrets`. A `Secret` is an object that contains a small amount of sensitive data so that you don't need to include confidential data in your application code. When creating a credential you can either **create a new secret** or use an [existing secret](#existing-secrets).

### Existing secrets

An existing secret is a secret that you have created before creating the credential. One way to create a secret is to use the [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret/#working-with-secrets){target=_blank}
creation tool to create a pre-existing secret for the credential. You must `label` these secrets so that they are registered in the Run:ai environment.

The following command makes the secret available to all projects in the cluster.

```console
kubectl label secret -n runai <SECRET_NAME> run.ai/cluster-wide-credentials=true
```

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

If you select the `Docker registry` credential:

1. Select a `Scope` for the credential.
2. In the `Credential name` field, enter a name for the credential.
3. In the `Secret` field, choose from `Existing secret` or `New secret`.

      * If you select `Existing secret`, select an unused secret from the drop down.
  
        !!! Note
            Existing secrets can't be used more than once.

      * If you choose `New secret`, enter a username and password.

4. Enter a URL for the docker registry, then press `Create credential` to create the credential.

If you select the `Access key` credential:

1. Select a `Scope` for the credential.
2. In the `Credential name` field, enter a name for the credential.
3. In the `Secret` field, choose from `Existing secret` or `New secret`.

      * If you select `Existing secret`, select an unused secret from the drop down.

        !!! Note
            Existing secrets can't be used more than once.  

      * If you choose `New secret`, enter an access key and access secret.

4. Press `Create credential` to create the credential.

If you select the `Username and password` credential:

1. Select a `Scope` for the credential.
2. In the `Credential name` field, enter a name for the credential.
3. In the `Secret` field, choose from `Existing secret` or `New secret`.

      * If you select `Existing secret`, select an unused secret from the drop down.
  
        !!! Note
            Existing secrets can't be used more than once.

      * If you choose `New secret`, enter a username and password.

4. Press `Create credential` to create the credential.

## Download Credentials Table

You can download the Credentials table to a CSV file. Downloading a CSV can provide a snapshot history of your credentials over the course of time, and help with compliance tracking. All the columns that are selected (displayed) in the table will be downloaded to the file.

To download the Credentials table to a CSV:
1. Open *Credentials*.
2. From the *Columns* icon, select the columns you would like to have displayed in the table.
3. Click on the ellipsis labeled *More*, and download the CSV.
