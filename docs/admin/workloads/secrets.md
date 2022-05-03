# Secrets in Jobs

## Kubernetes Secrets

Sometimes you want to use sensitive information within your code. Examples are: passwords, OAuth tokens, or ssh keys. The best practice for saving such information in Kubernetes is via __Kubernetes Secrets__. Kubernetes Secrets let you store and manage sensitive information. Access to secrets is limited via configuration.

A Kubernetes secret may hold multiple __key - value pairs__.

## Using Secrets in Run:ai Jobs

Our goal is to provide Run:ai Jobs with secrets as input in a secure way. Using the Run:ai command-line, you will be able to pass a reference to a secret that already exists in Kubernetes. 

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

## Attaching a secret to a Job on Submit

When you submit a new Job, you will want to connect the secret to the new Job. To do that, run:

```
runai submit -e <ENV-VARIABLE>=SECRET:<secret-name>,<secret-key> ....
```

For example:

```
runai submit -i ubuntu -e MYUSERNAME=SECRET:my-secret,username
```


### Secrets and Projects

<!-- !!! Important
    The feature described below is not enabled by default in Run:ai cluster installations -->

As per the note above, secrets are namespace-specific. If your secret relates to all Run:ai Projects, do the following to propagate the secret to all Projects:

* Create a secret within the `runai` namespace.
* Run the following once to allow Run:ai to propagate the secret to all Run:ai Projects:

```
runai-adm set secret <secret name> --cluster-wide
```

!!! Reminder
    The Run:ai Administrator CLI can be obtained [here](../runai-setup/config/cli-admin-install.md).

To delete a secret from all Run:ai Projects, run:

```
runai-adm remove secret <secret name> --cluster-wide
```

## Secrets and Templates

A Secret can be set at the template level. For additional information see [template configuration](templates.md)