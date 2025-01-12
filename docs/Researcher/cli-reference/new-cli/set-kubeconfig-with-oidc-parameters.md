# Add Run:ai authorization to kubeconfig


The runai kubeconfig set command allows users to configure their kubeconfig file with Run:AI authorization parameters. This setup enables users to gain access to the Kubernetes (k8s) cluster seamlessly.



*  There is no need to set the kubeconfig in order to properly work with the CLI. It is used only in order to work with external workloads under Run:ai authorization.





## Usage

To set the kubeconfig file, run the following command:

```
runai kubeconfig set
```

## Prerequisites
Before executing the command, ensure that

1. Cluster authentication is enabled
2.  The user have a kubeconfig file that includes the following elements:

### Cluster configuration

To enable cluster authentication, add the following flags to the Kubernetes server API of each cluster


```


spec:
  containers:
  - command:
    ...
    - --oidc-client-id=<OIDC_CLIENT_ID>
    - --oidc-issuer-url=url=https://<HOST>/auth/realms/<REALM>
    - --oidc-username-prefix=-
```


### User configuration

Add the following to the Kubernetes client configuration file (./kube/config)

```
apiVersion: v1
kind: Config
preferences:
  colors: true
current-context: <CONTEXT_NAME>
contexts:
- context:
    cluster: <CLUSTER_NAME>
    user: <USER_NAME>
  name: <CONTEXT_NAME>
clusters:
- cluster:
    server: <CLUSTER_URL>
    certificate-authority-data: <CLUSTER_CERT>
  name: <CLUSTER_NAME>
users:
- name: <USER_NAME>
```

* Make sure to replace values with the actual cluster information and user credentials.

* There can be multiple conext in the kubeconfig file, the command will config the current context

* When configuring the context, existing auth data will be run over.




For the full command reference see [here](./runai_kubeconfig_set.md)


