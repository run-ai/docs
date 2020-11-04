# Upgrading a Cluster Installation

## Upgrade

To upgrade a Run:AI cluster installation run the following:

``` shell 
wget https://github.com/run-ai/docs/blob/master/install/runai_new_crds.yaml
kubectl apply -f runai_new_crds.yaml
kubectl set image -n runai deployment/runai-operator \
      runai-operator=gcr.io/run-ai-prod/operator:<NEW_VERSION>
```

Replace ``<NEW_VERSION>`` with a version number you receive from Run:AI customer support.

To verify that the upgrade has succeeded run:

```
kubectl get pods -n runai
```

and make sure that all pods are running or completed.

## Find the current Run:AI cluster version

To find the current version of the Run:AI cluster, run:

```
kubectl get deployment runai-operator -n runai \
  -o jsonpath='{.spec.template.spec.containers[0].image}'
```
