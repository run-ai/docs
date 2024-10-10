# Propogating secrets as environment variables to workloads via the CLI

The following is a specific knowledge articles for Run:ai command-line interface users who wish to propagate a Kubernetes secret an an environment variable.

## Kubernetes Secrets

Sometimes you want to use sensitive information within your code. For example passwords, OAuth tokens, or ssh keys. The best practice for saving such information in Kubernetes is via **Kubernetes Secrets**. Kubernetes Secrets let you store and manage sensitive information. Access to secrets is limited via configuration.

A Kubernetes secret may hold multiple **key - value** pairs.

## Using Secrets in Run:ai Workloads

Our goal is to provide Run:ai Workloads with secrets as input in a secure way. Using the Run:ai command line, you will be able to pass a reference to a secret that already exists in Kubernetes.

## Creating a secret

For details on how to create a Kubernetes secret see: [https://kubernetes.io/docs/concepts/configuration/secret/](https://kubernetes.io/docs/concepts/configuration/secret/){target=_blank}. Here is an example:

``` YAML
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
  namespace: runai-<project-name>
data:
  username: am9obgo=
  password: bXktcGFzc3dvcmQK
```

Then run:
```
kubectl apply -f <file-name>
```

!!! Notes
    * Secrets are base64 encoded
    * Secrets are stored in the scope of a namespace and will not be accessible from other namespaces. Hence the reference to the Run:ai Project name above. Run:ai provides the ability to propagate secrets throughout all Run:ai Projects. See below.

## Attaching a secret to a Workload on Submit via CLI

When you submit a new Workload, you will want to connect the secret to the new Workload. To do that, run:

```
runai submit -e <ENV-VARIABLE>=SECRET:<secret-name>,<secret-key> ....
```

For example:

```
runai submit -i ubuntu -e MYUSERNAME=SECRET:my-secret,username
```

