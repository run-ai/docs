
# Install the Run:AI Backend 

The following are instructions for deploying Run:AI in an air-gapped environment.

## Prerequisites 


Before proceeding,

* Provide the required access control as detailed in the [Preperations](preparations.md) section.
* Install the third-party dependencies as detailed in the [Install Dependencies](ocp-dependencies.md) section.


## Edit Backend Configuration File

Change the following properties in the values file `runai-backend/runai-backend-helm-release.yaml`. 

### Get Data

Run:
```
kubectl get route -n openshift-console console --template '{{.spec.host}}{{"\n"}}'
``` 

The result will be in the form:  `console-openshift-console.<DOMAIN>`. Use the `<DOMAIN>` part, to replace multiple occurrences as described below.

Run:
```
oc serviceaccounts get-token default -n runai-backend
```

Use this as `<GRAFANA-TOKEN>` to replace multiple occurrences as described below

### Changes to Perform 

|  Replace |   With   | Description | 
|----------|----------|-------------| 
| `openshift` | set to `true` | |
| `backend.run.ai` | `admin.<DOMAIN>` <br> see above | URL to the Administration User Interface  | 
|  `http://runai-cluster-kube-prometh-prometheus.monitoring.svc:9090` | `https://thanos-querier.openshift-monitoring.svc.cluster.local:9091` | Prometheus Data Source Proxy. Multiple occurances. | 
| `postgresql.persistence.nfs.server` | Set IP address for network file storage ||
| `postgresql.persistence.nfs.path` | Set path to dedicated Run:AI installation folder on NFS | path should be pre-created and have full access rights |
| `backend.initTenant.admin` | Change password for [admin@run.ai](mailto:admin.run.ai) | This user is the master Backend Administrator | 
| `backend.initTenant.users` | Change password for [test@run.ai](mailto:test@run.ai) | This user is the first cluster user | 
| `<GRAFANA-TOKEN>` | The Grafana token extracted above  |  multiple occurances | 
| `nginx-ingress.enabled` | set to `false` | Disable ingress controller on OpenShift | 
|<img width=500/>|| 
 
<!-- | `tls.secretName` | name of Kubernetes secret under the runai-backend namespace | Secret contains certificate for `auth.runai.<company-name>` | -->


Save the configuration file.


## Install Backend

Run the helm command below (replace `<version>` with the version of the provided file):


=== "Airgapped"
    ```
    helm install runai-backend runai-backend/runai-backend-<version>.tgz -n \
        runai-backend -f runai-backend/runai-backend-helm-release.yaml 
    ```

=== "Connected"
    ```
    helm repo add runai-backend https://backend-charts.storage.googleapis.com
    helm repo update
    helm install runai-backend -n runai-backend \
        runai-backend/runai-backend -f <values-file> 
    ```


!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. 


## Connect to Administrator User Interface

* Go to: `http://admin.<DOMAIN>`. Log in using the default credentials: User: `test@run.ai`, Password: `password`
* Change the default password.


## Next Steps

Continue with installing a [Run:AI Cluster](cluster.md).
