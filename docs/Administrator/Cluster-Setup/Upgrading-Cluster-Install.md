
To upgrade a Run:AI cluster installation you must get a version number from Run:AI customer support. Then, run:

    kubectl set image -n runai deployment/runai-operator \
      runai-operator=gcr.io/run-ai-prod operator:NEW_VERSION

To verify that the upgrade has succeeded run:

    kubectl get pods -n runai

and make sure that all pods are running or completed.
