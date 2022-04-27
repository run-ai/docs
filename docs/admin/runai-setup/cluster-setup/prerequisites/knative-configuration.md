## Enable SchedulerName
1. Edit `config-features` ConfigMap under `knative-serving` namespace  
``kubectl edit cm -n knative-serving config-features``
2. Add `kubernetes.podspec-schedulername: enabled` to the `data` section, like so:
```
apiVersion: v1
data:
  kubernetes.podspec-schedulername: enabled
  _example: |-
    ################################
    #                              #
    #    EXAMPLE CONFIGURATION     #
    #                              #
    ################################
    ...
```