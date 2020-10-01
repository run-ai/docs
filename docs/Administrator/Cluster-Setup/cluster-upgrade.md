# Upgrading a Cluster Installation

## Upgrade

To upgrade a Run:AI cluster installation run the following

    kubectl set image -n runai deployment/runai-operator \
      runai-operator=gcr.io/run-ai-prod/operator:<NEW_VERSION>

Replace ``NEW_VERSION`` with a version number you receive from Run:AI customer support

To verify that the upgrade has succeeded run:

    kubectl get pods -n runai

and make sure that all pods are running or completed.

## Find the current Run:AI version

To find the current version of the Run:AI cluster, run:

    kubectl get deployment runai-operator -n runai -o jsonpath='{.spec.template.spec.containers[0].image}'


## Upgrade from older versions

If you are upgrading from version 1.0.56 or lower, you must first apply the following YAML:
```
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
    name: runaijobs.run.ai
spec:
    group: run.ai
    version: v1
    scope: Namespaced
    names:
        plural:  runaijobs
        singular: runaijob
        kind: RunaiJob
        shortNames:
        - rj
    subresources:
        status: {}
```
