
# Install the Run:AI Backend 

### Set Backend Configuration

Customize the Run:AI backend configuration file.

=== "Airgapped"
    Edit `runai-backend/runai-backend-helm-release.yaml`

=== "Connected"
    Generate a values file by running:
    ```
    runai-adm generate-values --domain runai.<company-name>
    ```


Change the following properties in the values file. 

|  Key     |   Change   | Description |
|----------|----------|-------------| 
| `nginx-ingress.controller.externalIPs` | `<RUNAI_IP_ADDRESS>` | IP address allocated for Run:AI.  |
| `postgresql.persistence.nfs.server` |  IP address for network file storage ||
| `postgresql.persistence.nfs.path` |  Path to dedicated Run:AI installation folder on NFS | Folder should be pre-created and have full access rights |
| `backend.https` | replace `key` and `crt` with public and private keys for `runai.<company-name>` |
||||
| __Optional:__ |
| `backend.researcher-service.url` | Replace`researcher.run.ai` with  `researcher.runai.<company-name>` | URL to the Researcher User Interface  |  
| `backend.initTenant.promProxy` <br> and <br> `grafana.datasources.datasources.yaml.datasources.url` | When using an existing Promethues service, replace this URL with the URL of the existing Prometheus service (obtain by running `kubectl get svc` on the Prometheus namespace) | Internal URL to Promethues server |
| `pspEnabled` | `<true/false>` | Set to `true` if using [PodSecurityPolicy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} | 
| `nginx-ingress.podSecurityPolicy` |  Set to `true` if using [PodSecurityPolicy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} |
| `backend.initTenant.admin` | Change password for admin@run.ai | This user is the master Backend administrator | 
| `backend.initTenant.users` | Change password for test@run.ai | This user is the first cluster user | 
|<img width=1300/>|||


---
title: Self Hosted installation over Kubernetes - Backend Setup
---

## Install Backend

Run the helm command below:

=== "Airgapped"
    ```
    helm install runai-backend runai-backend/runai-backend-<version>.tgz -n \
        runai-backend -f runai-backend/runai-backend-helm-release.yaml 
    ```
    (replace `<version>` with the backend version)

=== "Connected"
    ```
    helm repo add runai-backend https://backend-charts.storage.googleapis.com
    helm repo update
    helm install runai-backend -n runai-backend runai-backend/runai-backend  \
        -f runai-backend-values.yaml
    ```

!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. 

### Connect to Administrator User Interface

Go to: `runai.<company-name>`. Log in using the default credentials: User: `test@run.ai`, Password: `password`
<!-- 
### (Optional) LDAP Configuration

Follow the [LDAP Integration](ldap-integration.md) instructions. -->

## Next Steps

Continue with installing a [Run:AI Cluster](cluster.md).

