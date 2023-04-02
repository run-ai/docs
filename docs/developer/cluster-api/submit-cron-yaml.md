# Submit a Cron job via YAML

:octicons-versions-24: Version 2.10 and later.

The cron command-line utility is a job scheduler typically used to set up and maintain software environments at scheduled intervals. Run:ai now supports submitting jobs with cron using a YAML file. 

To submit a job using cron, run the following command:

```console
kubectl apply -f <file_name>.yaml
```

The following is an example YAML file:

```YAML
apiVersion: batch/v1
kind: CronJob
metadata:
  name: hello
spec:
  schedule: "* * * * *"
  jobTemplate:
    spec:
      template:
        metadata:
          labels:
          - (Mandatory) runai/queue: team-a
        spec:
          (Mandatory) schedulerName: runai-scheduler
          containers:
          - name: hello
            image: busybox:1.28
            imagePullPolicy: IfNotPresent
            command:
            - /bin/sh
            - -c
            - date; echo Hello from the Kubernetes cluster
          restartPolicy: OnFailure
          (Optional) priorityClassName: build / train / inference / interactivePreemptible
```
