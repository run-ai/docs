# Using a Docker Registry with Credentials

## Why?

Some Docker images are stored in private docker registries. For the Researcher to access the images, we will need to provide credentials for the registry.

## How?

There could be two business scenarios:

1. All researchers use single credentials for the registry. 
2. There exist separate registry credentials per Run:ai Project. 

### Single Credentials

For each private registry you must perform the following (The example below uses Docker Hub):

```
kubectl create secret docker-registry <secret_name> -n runai \ 
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=<user_name> --docker-password=<password>
```

Then:

```
kubectl label secret <secret_name> runai/cluster-wide="true" -n runai
```

* `<secret_name>` may be any arbitrary string
* `<user_name>` and `<password>` are the repository user and password

!!! Notes
         * The secret may take up to a minute to update in the system.
         * The above scheme relies on the cluster setting `clusterWideSecret` to be set to `true`


### Credentials per Project

For each Run:ai Project create a secret:

```
kubectl create secret docker-registry <secret_name> -n <NAMESPACE> \ 
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=<user_name> --docker-password=<password>
```

Where `<NAMESPACE>` is the namespace associated with the Project (typically its `runai-<PROJECT-NAME>`).

Then apply the secret to Run:ai by running:

```
kubectl patch serviceaccount default -n <NAMESPACE> -p '{"imagePullSecrets": [{"name": "<secret_name>"}]}'
```

## Google Cloud Registry
Follow the steps below to access private images in the Google Container Registry (GCR):

* Create a service-account in GCP. Provide it `Viewer` permissions and download a JSON key.
* Under GCR, go to image and locate the domain name. Example GCR domains can be `gcr.io`, `eu.gcr.io` etc. 
* On your local machine, log in to docker with the new credentials:
```
docker login -u _json_key -p "$(cat <config.json>)" <gcr-domain>
```
 Where `<gcr-domain>` is the GCR domain we have located, `<config.json>` is the GCP configuration file. This will generate an entry for the GCR domain in your  `~/.docker/config.json file`.

 * Open the `~/.docker/config.json` file.  Copy the JSON structure under the GCR domain into a new file called `~/docker-config.json`. When doing so, take care to __remove all newlines__. For example:
```
{"https://eu.gcr.io": { "auth": "<key>"}}
```

* Convert the file into base64:
```
cat ~/docker-config.json | base64
```
* Create a new file called `secret.yaml`:

``` yaml
apiVersion: v1
kind: Secret
metadata:
        name: gcr-secret
        namespace: runai
        labels:
        runai/cluster-wide: "true"
data:
        .dockerconfigjson: << PASTE_HERE_THE_LONG_BASE64_ENCODED_STRING >>
type: kubernetes.io/dockerconfigjson
```

* Apply to Kubernetes by running  the command:
```
kubectl create -f ~/secret.yaml
```
* Test your settings by submitting a which references an image from the GCR repository
