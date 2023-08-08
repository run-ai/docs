# Integrate Run:ai with Ray

Ray is an open-source unified framework for scaling AI and Python applications like machine learning. It provides the compute layer for parallel processing so that you don’t need to be a distributed systems expert.

## Install Ray operator

You must install KubeRay version 0.5.0 or greater in order to work with the different types of Ray workloads.

Use the following commands:

```bash
helm repo add kuberay https://ray-project.github.io/kuberay-helm/

helm install kuberay-operator kuberay/kuberay-operator -n kuberay-operator --version 0.5.0 --create-namespace
```

For more information, see [Deploying RayKube operator](https://docs.ray.io/en/latest/cluster/kubernetes/getting-started.html#deploying-the-kuberay-operator){target=_blank}.

## Submit a Ray job

Run:AI integrates with ray by interacting with the kuberay CRDs (RayJob, RayServe and RayCluster). The following is an example of RayJob scheduled by Run:AI.
Use the following command to submit your Ray job:

`kubectl apply -f <path/example-file-name.yaml>`

For more information, see [Run an example job](https://ray-project.github.io/kuberay/guidance/rayjob/#run-an-example-job){target=_blank}.

Example:

```yml
apiVersion: ray.io/v1alpha1
kind: RayJob
metadata:
  name: <name>
  namespace: <your_project_namespace>
spec:
  entrypoint: python /home/ray/samples/sample_code.py
  # runtimeEnv decoded to '{
  #    "pip": [
  #        "requests==2.26.0",
  #        "pendulum==2.1.2"
  #    ],
  #    "env_vars": {
  #        "counter_name": "test_counter"
  #    }
  #}'
  shutdownAfterJobFinishes: true
  #ttlSecondsAfterFinished: 30
  runtimeEnv: ewogICAgInBpcCI6IFsKICAgICAgICAicmVxdWVzdHM9PTIuMjYuMCIsCiAgICAgICAgInBlbmR1bHVtPT0yLjEuMiIKICAgIF0sCiAgICAiZW52X3ZhcnMiOiB7ImNvdW50ZXJfbmFtZSI6ICJ0ZXN0X2NvdW50ZXIifQp9Cg==
  rayClusterSpec:
    rayVersion: '2.3.0' # should match the Ray version in the image of the containers
    # Ray head pod template
    headGroupSpec:
      serviceType: ClusterIP # optional
      # the following params are used to complete the ray start: ray start --head --block --redis-port=6379 ...
      rayStartParams:
        dashboard-host: '0.0.0.0'
        num-cpus: '2' # can be auto-completed from the limits
        block: 'true'
      #pod template
      template:
        spec:
          containers:
            - name: ray-head
              image: rayproject/ray:2.3.0
              ports:
                - containerPort: 6379
                  name: gcs-server
                - containerPort: 8265 # Ray dashboard
                  name: dashboard
                - containerPort: 10001
                  name: client
                - containerPort: 8000
                  name: serve
              volumeMounts:
                - mountPath: /home/ray/samples
                  name: code-sample
          schedulerName: runai-scheduler
          volumes:
            # You set volumes at the Pod level, then mount them into containers inside that Pod
            - name: code-sample
              configMap:
                # Provide the name of the ConfigMap you want to mount.
                name: ray-job-code-sample
                # An array of keys from the ConfigMap to create as files
                items:
                  - key: sample_code.py
                    path: sample_code.py
    workerGroupSpecs:
      # the pod replicas in this group typed worker
      - replicas: 1 # example
        minReplicas: 1 # example
        maxReplicas: 5 # example
        # logical group name, for this called small-group, also can be functional
        groupName: small-group
        rayStartParams:
          block: 'true'
        #pod template
        template:
          spec:
            initContainers:
              # the env var $FQ_RAY_IP is set by the operator if missing, with the value of the head service name
              - name: init
                image: busybox:1.28
                command: [ 'sh', '-c', "until nslookup $RAY_IP.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local; do echo waiting for K8s Service $RAY_IP; sleep 2; done" ]
            containers:
              - name: ray-worker # must consist of lower case alphanumeric characters or '-', and must start and end with an alphanumeric character (e.g. 'my-name',  or '123-abc'
                image: rayproject/ray:2.3.0
                lifecycle:
                  preStop:
                    exec:
                      command: [ "/bin/sh","-c","ray stop" ]
            schedulerName: runai-scheduler
######################Ray code sample#################################
# this sample is from https://docs.ray.io/en/latest/cluster/job-submission.html#quick-start-example
# it is mounted into the container and executed to show the Ray job at work
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: ray-job-code-sample
data:
  sample_code.py: |
    import ray
    import os
    import requests

    ray.init()

    @ray.remote
    class Counter:
        def __init__(self):
            # Used to verify runtimeEnv
            self.name = os.getenv("counter_name")
            self.counter = 0

        def inc(self):
            self.counter += 1

        def get_counter(self):
            return "{} got {}".format(self.name, self.counter)

    counter = Counter.remote()

    for _ in range(5):
        ray.get(counter.inc.remote())
        print(ray.get(counter.get_counter.remote()))

    print(requests.__version__)
```

## Ray autoscaling cluster

For more information, see [Ray autoscaling](https://docs.run.ai/v2.12/admin/workloads/policies/#creating-a-policy){target=_blank}.

Use the following command to submit your Ray autoscaling cluster:

`kubectl apply -f <path/example-file-name.yaml>`

Example:

```yml
# This config demonstrates KubeRay's Ray autoscaler integration.
# The resource requests and limits in this config are too small for production!
# For an example with more realistic resource configuration, see
# ray-cluster.autoscaler.large.yaml.
apiVersion: ray.io/v1alpha1
kind: RayCluster
metadata:
  labels:
    controller-tools.k8s.io: "1.0"
    # A unique identifier for the head node and workers of this cluster.
  name: <name>
  namespace: <your_project_namespace>
spec:
  # The version of Ray you are using. Make sure all Ray containers are running this version of Ray.
  rayVersion: '2.3.0'
  # If enableInTreeAutoscaling is true, the autoscaler sidecar will be added to the Ray head pod.
  # Ray autoscaler integration is supported only for Ray versions >= 1.11.0
  # Ray autoscaler integration is Beta with KubeRay >= 0.3.0 and Ray >= 2.0.0.
  enableInTreeAutoscaling: true
  # autoscalerOptions is an OPTIONAL field specifying configuration overrides for the Ray autoscaler.
  # The example configuration shown below below represents the DEFAULT values.
  # (You may delete autoscalerOptions if the defaults are suitable.)
  autoscalerOptions:
    # upscalingMode is "Default" or "Aggressive."
    # Conservative: Upscaling is rate-limited; the number of pending worker pods is at most the size of the Ray cluster.
    # Default: Upscaling is not rate-limited.
    # Aggressive: An alias for Default; upscaling is not rate-limited.
    upscalingMode: Default
    # idleTimeoutSeconds is the number of seconds to wait before scaling down a worker pod which is not using Ray resources.
    idleTimeoutSeconds: 60
    # image optionally overrides the autoscaler's container image.
    # If instance.spec.rayVersion is at least "2.0.0", the autoscaler will default to the same image as
    # the ray container. For older Ray versions, the autoscaler will default to using the Ray 2.0.0 image.
    ## image: "my-repo/my-custom-autoscaler-image:tag"
    # imagePullPolicy optionally overrides the autoscaler container's default image pull policy (IfNotPresent).
    imagePullPolicy: IfNotPresent
    # Optionally specify the autoscaler container's securityContext.
    securityContext: {}
    env: []
    envFrom: []
    # resources specifies optional resource request and limit overrides for the autoscaler container.
    # The default autoscaler resource limits and requests should be sufficient for production use-cases.
    # However, for large Ray clusters, we recommend monitoring container resource usage to determine if overriding the defaults is required.
    resources:
      limits:
        cpu: "500m"
        memory: "512Mi"
      requests:
        cpu: "500m"
        memory: "512Mi"
  # Ray head pod template
  headGroupSpec:
    serviceType: ClusterIP # optional
    # the following params are used to complete the ray start: ray start --head --block ...
    rayStartParams:
      dashboard-host: '0.0.0.0'
      block: 'true'
      # num-cpus: '1' # can be auto-completed from the limits
      # Use `resources` to optionally specify custom resource annotations for the Ray node.
      # The value of `resources` is a string-integer mapping.
      # Currently, `resources` must be provided in the specific format demonstrated below:
      # resources: '"{\"Custom1\": 1, \"Custom2\": 5}"'
    #pod template
    template:
      spec:
        containers:
        # The Ray head container
        - name: ray-head
          image: rayproject/ray:2.3.0
          ports:
          - containerPort: 6379
            name: gcs
          - containerPort: 8265
            name: dashboard
          - containerPort: 10001
            name: client
          lifecycle:
            preStop:
              exec:
                command: ["/bin/sh","-c","ray stop"]
          # The resource requests and limits in this config are too small for production!
          # For an example with more realistic resource configuration, see
          # ray-cluster.autoscaler.large.yaml.
          # It is better to use a few large Ray pod than many small ones.
          # For production, it is ideal to size each Ray pod to take up the
          # entire Kubernetes node on which it is scheduled.
          resources:
            limits:
              cpu: "1"
              memory: "2G"
            requests:
              # For production use-cases, we recommend specifying integer CPU reqests and limits.
              # We also recommend setting requests equal to limits for both CPU and memory.
              # For this example, we use a 500m CPU request to accomodate resource-constrained local
              # Kubernetes testing environments such as KinD and minikube.
              cpu: "500m"
              # The rest state memory usage of the Ray head node is around 1Gb. We do not
              # recommend allocating less than 2Gb memory for the Ray head pod.
              # For production use-cases, we recommend allocating at least 8Gb memory for each Ray container.
              memory: "2G"
        schedulerName: runai-scheduler
  workerGroupSpecs:
  # the pod replicas in this group typed worker
  - replicas: 1 # example
    minReplicas: 1 # example
    maxReplicas: 10 # example
    # logical group name, for this called small-group, also can be functional
    groupName: small-group
    # If worker pods need to be added, we can increment the replicas.
    # If worker pods need to be removed, we decrement the replicas, and populate the workersToDelete list.
    # The operator will remove pods from the list until the desired number of replicas is satisfied.
    # If the difference between the current replica count and the desired replicas is greater than the
    # number of entries in workersToDelete, random worker pods will be deleted.
    #scaleStrategy:
    #  workersToDelete:
    #  - raycluster-complete-worker-small-group-bdtwh
    #  - raycluster-complete-worker-small-group-hv457
    #  - raycluster-complete-worker-small-group-k8tj7
    # the following params are used to complete the ray start: ray start --block ...
    rayStartParams:
      block: 'true'
    #pod template
    template:
      spec:
        initContainers:
        # the env var $FQ_RAY_IP is set by the operator if missing, with the value of the head service name
        - name: init
          image: busybox:1.28
          command: ['sh', '-c', "until nslookup $RAY_IP.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local; do echo waiting for K8s Service $RAY_IP; sleep 2; done"]
        containers:
        - name: ray-worker
          image: rayproject/ray:2.3.0
          lifecycle:
            preStop:
              exec:
                command: ["/bin/sh","-c","ray stop"]
          # The resource requests and limits in this config are too small for production!
          # For an example with more realistic resource configuration, see
          # ray-cluster.autoscaler.large.yaml.
          # It is better to use a few large Ray pod than many small ones.
          # For production, it is ideal to size each Ray pod to take up the
          # entire Kubernetes node on which it is scheduled.
          resources:
            limits:
              cpu: "1"
              memory: "1G"
            # For production use-cases, we recommend specifying integer CPU reqests and limits.
            # We also recommend setting requests equal to limits for both CPU and memory.
            # For this example, we use a 500m CPU request to accomodate resource-constrained local
            # Kubernetes testing environments such as KinD and minikube.
            requests:
              cpu: "500m"
              memory: "1G"
        schedulerName: runai-scheduler
```
