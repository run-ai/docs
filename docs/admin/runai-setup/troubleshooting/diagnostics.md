# Diagnostic Tools

## Add Verbosity to the Database container

Run:ai Self-hosted installation contains an internal database. To diagnose database issues, you can run the database in debug mode.

In the runai-backend-values, search for `postgresql`. Add: 

``` YAML
postgresql:
  image:
    debug: true
```

Re-install the Run:ai backend and then review the database logs by running: 

```
kubectl logs -n runai-backend runai-postgresql-0
```


## Internal Networking Issues

Run:ai is based on Kubernetes. Kubernetes runs its own internal subnet with a separate DNS service. If you see in the logs that services have trouble connecting, the problem may reside there.  You can find further information on how to debug Kubernetes DNS [here](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/){target=_blank}. Specifically, it is useful to start a Pod with networking utilities and use it for network resolution:

```
kubectl run -i --tty netutils --image=dersimn/netutils -- bash
```

## Add verbosity to Prometheus

Add verbosity to Prometheus by editing RunaiConfig:

```
kubectl edit runaiconfig runai -n runai
```

Add a `debug` log level:

``` YAML
prometheus-operator:
  prometheus:
    prometheusSpec:
      logLevel: debug
```

Run:
``` 
kubectl logs  prometheus-runai-prometheus-operator-prometheus-0 prometheus \
      -n monitoring -f --tail 100
```
