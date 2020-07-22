## Why?

Some Docker images are stored in private docker registries. In order for the researcher to access the images, we will need to provide credentials for the registry.

## How?

For each private registry you must perform the following (The example below uses Docker Hub):

    kubectl create secret docker-registry <secret_name> -n runai \ 
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=<user_name> --docker-password=<password>

Then:
    kubectl label secret <secret_name> runai/cluster-wide="true" -n runai

* secret_name may be any arbitrary string.
* user_name and password are the repository user and password. 

__Note__: the secret may take up to a minute to update in the system

## Google Cloud Image Repository
To access the Google Container Repository (GCR),  you need to obtain a key-file to a service account (config.json) which allows access to the repository. You then merge it into the cluster:

    kubectl create secret generic <secret_name> -n runai \
        --from-file=.dockerconfigjson=<path/to/.docker/config.json> \
        --type=kubernetes.io/dockerconfigjson

Then run the label command as described above.