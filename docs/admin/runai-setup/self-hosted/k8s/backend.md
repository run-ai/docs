
# Install the Run:AI Control Plane (Backend) 

## Create a Control Plane Configuration

Customize the Run:AI control plane configuration file.

=== "Connected"
    Generate a values file by running:
    ```
    runai-adm generate-values --domain runai.<company-name> --tls-cert <file-name> --tls-key <file-name> --nfs-server <nfs-server-address> -nfs-path <path-in-nfs>  
    ```
=== "Airgapped"
    Generate a values file by running the following under the `deploy` folder:
    ```
    runai-adm generate-values  --domain runai.<company-name> --airgapped --tls-cert <file-name> --tls-key <file-name> --nfs-server <nfs-server-address> -nfs-path <path-in-nfs>  
    ```

Where:

* --tls flags relate to public and private keys for `runai.<company-name>`
* --nfs flags relate to NFS server location where Run:AI can create files. For using alternative storage mechanisms see optional values below 



## Edit Configuration File

Change the following properties in the values file. 

|  Key     |   Change   | Description |
|----------|----------|-------------| 
| `nginx-ingress.controller.externalIPs` | `<RUNAI_IP_ADDRESS>` | IP address allocated for Run:AI.  |
| `backend.https` | replace `key` and `crt` with public and private keys for `runai.<company-name>` |
| `thanos.receive.persistence` | Permanent storage for Run:AI metrics | See Postgresql persistence above. Can use the same location |
||||
| __Optional:__ |
| `postgresql.persistence` | PostgreSQL permanent storage via a Persistent Volume.  | You can either use `storageClassName` to create a PV automatically or set `nfs.server` and `nfs.path` to provide the network file storage for the PV. The folder in the path should be pre-created and have full access rights |
| `backend.initTenant.promProxy` <br> and <br> `grafana.datasources.datasources.yaml.datasources.url` | When using an existing Promethues service, replace this URL with the URL of the existing Prometheus service (obtain by running `kubectl get svc` on the Prometheus namespace) | Internal URL to Promethues server |
| `pspEnabled` | `<true/false>` | Set to `true` if using [PodSecurityPolicy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} | 
| `nginx-ingress.podSecurityPolicy` |  Set to `true` if using [PodSecurityPolicy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} |
| `backend.initTenant.admin` | Change password for admin@run.ai | This user is the master Control Plane administrator | 
|<img width=1300/>|||



## Install the Control Plane (Backend)

Run the helm command below:


=== "Connected"
    ```
    helm repo add runai-backend https://backend-charts.storage.googleapis.com
    helm repo update
    helm install runai-backend -n runai-backend runai-backend/runai-backend  \
        -f runai-backend-values.yaml
    ```

    !!! Info
        To install a specific version, add `--version <version>` to the install command.

=== "Airgapped"
    ```
    helm install runai-backend runai-backend/runai-backend-<version>.tgz -n \
        runai-backend -f runai-backend-values.yaml 
    ```
    (replace `<version>` with the Run:AI control plane version)

!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. 

### Connect to Administrator User Interface

Go to: `runai.<company-name>`. Log in using the default credentials: User: `test@run.ai`, Password: `password`
<!-- 
### (Optional) LDAP Configuration

Follow the [LDAP Integration](ldap-integration.md) instructions. -->

## Next Steps

Continue with installing a [Run:AI Cluster](cluster.md).

