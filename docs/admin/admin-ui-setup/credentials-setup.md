# Credentials

Credentials are used to unlock protected resources such as applications, containers, and other assets.

## Types of credentials

The Credential manager in the Run:ai environment supports 4 types of credentials:

1. Docker registry.
2. Access key.
3. User name and password.
4. [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret){target=_blank}.

## Configuring Credentials

**Prerequisites**

1. `Workspaces` are enabled.
2. Target resource user-id and password for creating a secret in the UI.
3. Configured pre-existing secrets with the applicable `label`.

### Docker registry

1. Go to `Settings | Credentials`.
2. Press `New Credentials`.
3. Select `Docker registry`.
4. In the `Project` field, select a project from the drop down.

      * Choose `All` to add the credential to all current and future projects.

5. In the `Credential name` field, enter a name for the credential.
6. In the `Secret` field, choose from `Existing secret` or `New secret`.

      * If you select `Existing secret`, select an unused secret from the drop down.
  
        !!! Note
            Existing secrets can't be used more than once.

      * If you choose `New secret`, enter a username and password.

7. Enter a URL for the docker registry, then press `Create credential` to create the credential.

### Access key

1. Go to `Settings | Credentials`.
2. Press `New Credentials`.
3. Select `Access key`.
4. In the `Project` field, select a project from the drop down.

      * Choose `All` to add the credential to all current and future projects.

5. In the `Credential name` field, enter a name for the credential.
6. In the `Secret` field, choose from `Existing secret` or `New secret`.

      * If you select `Existing secret`, select an unused secret from the drop down.

        !!! Note
            Existing secrets can't be used more than once.  

      * If you choose `New secret`, enter an access key and access secret.

7. Press `Create credential` to create the credential.

### Username and password

1. Go to `Settings | Credentials`.
2. Press `New Credentials`.
3. Select `Username & password`.
4. In the `Project` field, select a project from the drop down.

      * Choose `All` to add the credential to all current and future projects.

5. In the `Credential name` field, enter a name for the credential.
6. In the `Secret` field, choose from `Existing secret` or `New secret`.

      * If you select `Existing secret`, select an unused secret from the drop down.
  
        !!! Note
            Existing secrets can't be used more than once.

      * If you choose `New secret`, enter a username and password.

7. Press `Create credential` to create the credential.

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

### User-id and password

You can create a credential using a user-id and password. Use the user-id and password of the target resource.




