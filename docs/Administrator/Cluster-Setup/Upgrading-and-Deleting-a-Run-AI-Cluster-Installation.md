## Upgrading a Run:AI Cluster Installation

To upgrade a Run:AI cluster installation you must get a version number from Run:AI customer support. Then, run:

    kubectl set image -n runai deployment/runai-operator \
      runai-operator=gcr.io/run-ai-prod operator:NEW_VERSION

To verify that the upgrade has succeeded run:

    kubectl get pods -n runai

and make sure that all pods are running or completed

##Deleting a Run:AI Cluster Installation

To delete a Run:AI Cluster installation run the following commands:

    kubectl delete RunaiConfig runai -n runai
    kubectl delete deployment runai-operator -n runai
    kubectl delete crd 
    kubectl delete namespace runai
