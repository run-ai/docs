# Upgrading a Cluster Installation

## Upgrade

To upgrade a Run:AI cluster, find out your current cluster version (see command below)

If the cluster version is 1.0.76 or earlier, run:

``` shell
kubectl apply -f https://raw.githubusercontent.com/run-ai/docs/master/install/runai_new_crds.yaml
kubectl scale --replicas=0 deployment/runai-operator -n runai
kubectl delete sts -n runai prometheus-runai-prometheus-operator-prometheus \
      runai-prometheus-pushgateway
kubectl set image -n runai deployment/runai-operator \
      runai-operator=gcr.io/run-ai-prod/operator:<NEW_VERSION>
kubectl scale --replicas=1 deployment/runai-operator -n runai

```

If the cluster version is 1.0.77, run:

``` shell
kubectl apply -f https://raw.githubusercontent.com/run-ai/docs/master/install/runai_new_crds.yaml
kubectl scale --replicas=0 deployment/runai-operator -n runai
kubectl delete sts -n runai runai-db
kubectl set image -n runai deployment/runai-operator \
      runai-operator=gcr.io/run-ai-prod/operator:<NEW_VERSION>
kubectl scale --replicas=1 deployment/runai-operator -n runai

```

If cluster version is 1.0.78 or later, run the following:

``` shell 
kubectl apply -f https://raw.githubusercontent.com/run-ai/docs/master/install/runai_new_crds.yaml
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
