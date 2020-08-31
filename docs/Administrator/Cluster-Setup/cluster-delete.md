# Deleting a Cluster Installation

To delete a Run:AI Cluster installation run the following commands:

    kubectl delete RunaiConfig runai -n runai
    kubectl delete deployment runai-operator -n runai
    kubectl delete crd runaiconfigs.run.ai
    kubectl delete namespace runai
