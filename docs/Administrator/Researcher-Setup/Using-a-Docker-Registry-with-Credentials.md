## Why?

Some Docker images are stored in private docker registries. In order for the researcher to access the images, we will need to provide credentials for the registry.

## How?

For each private registry you must perform the following (The example below uses Docker Hub):

    kubectl create secret docker-registry <secret_name> -n runai \ 
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=<user_name> --docker-password=<password>

Then:

    kubectl label secret <secret_name> runai/cluster-wide="true" -n runai

* secret_name may be any arbitrary string
* user_name and password are the repository user and password 

__Note__: the secret may take up to a minute to update in the system.

## Google Cloud Image Repository
To access the Google Container Repository (GCR),  you need to:

* Create a service-account in GCP. Provide it ``Storage Object Viewer`` permissions and download a JSON key.
* Under GCR, go to image and locate the domain name. Example GCR domains can be gcr.io, eu.gcr.io etc. 
* Run the command below: 

        kubectl create secret docker-registry <secret_name> -n runai \
        --docker-server=<gcr-domain> \
        --docker-username=_json_key \
        --docker-password="$(cat <config.json>)" \
        --docker-email=any@valid.email

Where ``gcr-domain`` is the GCR domain we have located, ``<config.json>`` is the GCP configuration file, ``<secret-name>`` is an arbitrary name.

Then run:

    kubectl label secret <secret_name> runai/cluster-wide="true" -n runai
