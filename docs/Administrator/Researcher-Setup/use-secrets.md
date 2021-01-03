# Secrets in Jobs

## Kubernetes Secrets

Sometimes you want to use sensitive information within your code. Examples are: passwords, OAuth tokens, or ssh keys. The best practice for saving such information in Kubernetes is via __Kubernetes Secrets__. Kubernetes Secrets let you store and manage sensitive information. Access to secrets is limited via configuration.

A Kubernetes secret may hold multiple __key - value pairs__.

## Using Secrets in Run:AI Jobs

Our goal is to provide Run:AI Jobs with secrets as an input in a secure way. Using the Run:AI command-line, you will be able to pass a reference to a secret that already exists in Kubernetes. 

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
    * Secrets are stored in the scope of a namespace and will not be accessible from other namespaces. Hence the reference to the Run:AI Project name above. Run:AI provides the ability to propagate secrets throughout all Run:AI Projects. See below.

## Attaching a secret to a Job on Submit

When you start a Job, you want to connect the secret to the new Job. To do that, run:

```
runai submit -e <ENV-VARIABLE>=SECRET:<secret-name>,<secret-key> ....
```

For example:

```
runai submit -i ubuntu -e MYUSERNAME=SECRET:my-secret,username
```


### Secrets and Projects

As per the note above, secrets are namespace-specific. If your secret relates to all Run:AI Projects, do the following to propagate the secret to all Projects:

* When creating a secret, set the namespace to be ``runai``
* Run the following once to allow Run:AI to propagate the secret:

```
kubectl label secret <secret_name> runai/cluster-wide="true" -n runai
```

## Secrets and Templates

A Secret can be set at the template level. For additional information see [template configuration](template-config.md)