# Credentials

Credentials are used to unlock protected resources such as applications, containers, and other assets. Establishing Credentials in the Run:ai environment is based on a user-id and password, or on [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret){target=_blank}. Credentials can be created using only one of these options.

## Types of credentials

The Credential manager in the Run:ai environment supports 2 types of credentials:

1. User-id and password.
2. Kubernetes created secret.

### User-id and password

You can create a credential using a user-id and password. Use the user-id and password of the target resource.

### Kubernetes created secret

You can use the [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret/#working-with-secrets){target=_blank}
creation tool to create a pre-existing secret that can be used when creating the credential. You must `label` these secrets so that they are registered in the Run:ai environment.

The following command makes the secret available to all projects in the cluster.

```console
kubectl label secret -n runai <SECRET_NAME> run.ai/cluster-wide-credentials=true
```

The following command makes the secret available to a specific project in the cluster.

```console
kubectl label secret -n <NAMESPACE_OF_PROJECT> <SECRET_NAME> run.ai/credentials=true
```

## Configuring Credentials

**Prerequisites**

1. `Workspaces` are enabled.
2. Target resource user-id and password for creating a secret in the UI.
3. Configured pre-existing secrets with the applicable `label`.

**To configure credentials**:

1. Go to `Settings | Credentials`.
2. Press `New Credentials`.
3. Select `Access key` or `Username & password`.
4. In the `New Credential` window, fill in following fields:

    1. In the `Project` field, select a project from the drop down.

         If you choose `All` the credential can be added to all current and future projects.

    2. In the `Credential name` field, enter a name for the credential.
    3. In the `Secret` field, choose from `Existing secret` or `New secret`.

         If you select `Existing secret`, you will be able to select an unused secret from the drop down.

         If you choose `New secret`, you will be able enter username and password for this credential.

        !!! Note
            Existing secrets can't be used more than once.

5. Press `Create cedential` to create the credential.
