# Add Run:ai authorization to kubeconfig

The ***runai kubeconfig set*** command allows users to configure their kubeconfig file with Run:AI authorization token. This setup enables users to gain access to the Kubernetes (k8s) cluster seamlessly.

* There is no need to set the kubeconfig to work with the CLI properly. It is used only to work with external workloads under Run:ai authorization.

## Usage

To set the token inside the kubeconfig file, run the following command:

```
runai kubeconfig set
```

## 

## Prerequisites

Before executing the command, ensure that

1. Cluster authentication is configured and enabled.
2. The user has a kubeconfig file configured.
3. The user is logged in (use the [runai login](http://./runai_login.md)  command)

### 

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

### 

### User Kubeconfig configuration

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
* There can be multiple contexts in the kubeconfig file, the command will config the current context

For the full command reference see [here](http://./guides/runai_kubeconfig_set.md)  
