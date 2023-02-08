
# Install the Run:ai Control Plane 

## Create a Control Plane Configuration

Create a configuration file to install the Run:ai control plane:

=== "Connected"
    Generate a values file by running:
    ``` bash 
    runai-adm generate-values \
        --external-ips <ip> \ # (1)
        --domain <dns-record> \ # (2) 
        --tls-cert <file-name>  --tls-key <file-name> \ # (3)  
        --nfs-server <nfs-server-address> --nfs-path <path-in-nfs>  # (4)
    ```

    1. An available, IP Address that is accessible from Run:ai Users' machines. Typically (but not always) the IP of one of the nodes. 
    2. DNS A record such as `runai.<company-name>` or similar. The A record should point to the IP address above. 
    3. TLS certificate and private key for the above domain.
    4. NFS server location where Run:ai can create files. For using alternative storage mechanisms see optional values below 


    !!! Note
        In cloud environments, the flag `--external-ips` should contain both the internal and external IPs (comma separated)

    A file called `runai-backend-values.yaml` will be created.


=== "Airgapped Run:ai 2.7"
    Generate a values file by running the following __under the `deploy` folder__:
    ``` bash
    runai-adm generate-values \
        --external-ips <ip> \ # (1)
        --domain <dns-record> \ # (2) 
        --tls-cert <file-name>  --tls-key <file-name> \ # (3)  
        --nfs-server <nfs-server-address> --nfs-path <path-in-nfs> \ # (4)
        --airgapped
    ```

    1. An available, IP Address that is accessible from Run:ai Users' machines. Typically (but not always) the IP of one of the nodes. 
    2. DNS A record such as `runai.<company-name>` or similar. The A record should point to the IP address above. 
    3. TLS certificate and private key for the above domain.
    4. NFS server location where Run:ai can create files. For using alternative storage mechanisms see optional values below 

    Ignore the message about a downloaded file.


=== "Airgapped Run:ai 2.8 and above"
    Generate a values file by running the following __under the `deploy` folder__:
    ``` bash
    runai-adm generate-values \
        --external-ips <ip> \ # (1)
        --domain <dns-record> \ # (2) 
        --tls-cert <file-name>  --tls-key <file-name> \ # (3)  
        --nfs-server <nfs-server-address> --nfs-path <path-in-nfs> \ # (4)
        --registry <docker-registry-address> #(5)
    ```

    1. An available, IP Address that is accessible from Run:ai Users' machines. Typically (but not always) the IP of one of the nodes. 
    2. DNS A record such as `runai.<company-name>` or similar. The A record should point to the IP address above. 
    3. TLS certificate and private key for the above domain.
    4. NFS server location where Run:ai can create files. For using alternative storage mechanisms see optional values below 
    5. Docker Registry address in the form of `NAME:PORT` (do not add `https`):


    Ignore the message about a downloaded file.

## (Optional) Edit Configuration File

There may be cases where you need to change properties in the values file as follows:

|  Key     |   Change   | Description |
|----------|----------|-------------| 
| `backend.initTenant.promProxy` <br> and <br> `grafana.datasources.datasources.yaml.datasources.url` | When using an existing Prometheus service, replace this URL with the URL of the existing Prometheus service (obtain by running `kubectl get svc` on the Prometheus namespace) | Internal URL to Prometheus server |
| `postgresql.persistence` | PostgreSQL permanent storage via a Persistent Volume  | You can either use `storageClassName` to create a PV automatically or set `nfs.server` and `nfs.path` to provide the network file storage for the PV. The folder in the path should be pre-created and have full access rights. This key is now covered under the runai-adm flags above |
| `nginx-ingress.controller.externalIPs` | `<RUNAI_IP_ADDRESS>` | IP address allocated for Run:ai. This key is now covered under the runai-adm flags above  |
| `backend.https` | Replace `key` and `crt` with public and private keys for `runai.<company-name>`. This key is now covered under the runai-adm flags above|
| `thanos.receive.persistence` | Permanent storage for Run:ai metrics | See `postgresql.persistence` above. Can use the same location. This key is now covered under the runai-adm flags above |
| `backend.initTenant.admin` | Change password for admin@run.ai | This user is the master Control Plane administrator | 

## Upload images (Airgapped only)

Upload images to a local Docker Registry. Set the Docker Registry address in the form of `NAME:PORT` (do not add `https`):

```
export REGISTRY_URL=<Docker Registry address>
```

Run the following script (you must have at least 20GB of free disk space to run): 

```  
sudo -E ./prepare_installation.sh
```

If Docker is configured to [run as non-root](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user){target=_blank} then `sudo` is not required.

## Install the Control Plane

Run the helm command below:


=== "Connected"
    ```
    helm repo add runai-backend https://backend-charts.storage.googleapis.com
    helm repo update
    helm install runai-backend -n runai-backend runai-backend/runai-backend  \
        -f runai-backend-values.yaml
    ```

    !!! Info
        To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-backend`.

=== "Airgapped"
    ```
    helm install runai-backend runai-backend-<version>.tgz -n \
        runai-backend -f runai-backend-values.yaml 
    ```
    (replace `<version>` with the Run:ai control plane version)

!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. 

### Connect to Run:ai User Interface

Go to: `runai.<company-name>`. Log in using the default credentials: User: `test@run.ai`, Password: `Abcd!234`. Go to the Users area and change the password. 


## (Optional) Enable "Forgot password"

To support the “Forgot password” functionality, follow the steps below.

* Go to `runai.<company-name>/auth` and Log in. 
* Under `Realm settings`, select the `Login` tab and enable the `Forgot password` feature.
* Under the `Email` tab, define an SMTP server, as explained [here](https://www.keycloak.org/docs/latest/server_admin/#_email){target=_blank}

## Next Steps

Continue with installing a [Run:ai Cluster](cluster.md).

