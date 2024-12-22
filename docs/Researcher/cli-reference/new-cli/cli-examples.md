This article provides examples of popular use cases illustrating how to use the Command Line Interface (CLI)

## Login

### Login via run:ai sign in page (web)
You can login from the UI, if you are using SSO or credentials
```shell
runai login
```
### Login via terminal (credentials)

```shell
runai login user -u john@acme.com -p "password"
```

## Configuration

### Setting a default project
```shell
runai project set "project-name"
```


## Submitting a workload

### Naming a workload
Use the commands below to provide a name for a workload.

#### Setting a the workload name ( my_workload_name)
```shell
runai workspace submit my-workload-name -p test -i ubuntu 
```

#### Setting a random name with prefix (prefix=workload type)
```shell
    runai workspace submit -p test -i ubuntu 
```
#### Setting a random name with specific prefix (prefix determined by flag)

```shell
runai workspace submit --prefix-name my-prefix-workload-name -p test -i ubuntu 
```

### Labels and annotations

#### Labels
```shell
runai workspace submit -p test -i ubuntu --label name=value --label name2=value2
```

#### Annotations
```shell
runai workspace submit -p test -i ubuntu --annotation name=value --annotation name2=value2
```

### Container's environment variables
```shell
runai workspace submit -p test -i ubuntu -e name=value -e name2=value2
```
### Requests and limits
```shell
runai workspace submit  -p alon -i runai.jfrog.io/demo/quickstart-demo   --cpu-core-request 0.3 --cpu-core-limit 1 --cpu-memory-request 50M --cpu-memory-limit 1G  --gpu-devices-request 1 --gpu-memory-request 1G
```

### Submit and attach to process
```shell
runai workspace submit  -p alon -i python  --attach -- python3
```
### Submit a jupiter notebook 
```shell
runai workspace submit --image jupyter/scipy-notebook -p alon --gpu-devices-request 1 --external-url container=8888 --name-prefix jupyter --command -- start-notebook.sh --NotebookApp.base_url='/${RUNAI_PROJECT}/${RUNAI_JOB_NAME}' --NotebookApp.token=''
```


### Distributed with TensorFlow framework
```shell
runai distributed submit -f TF --workers=5 --no-master -g 1 -i kubeflow/tf-mnist-with-summaries:latest -p alon --command -- python /var/tf_mnist/mnist_with_summaries.py --max_steps 1000000
```

### Multi pod submission

```shell

runai training submit  -i alpine -p test --parallelism 2 --completions 2  -- sleep 100000
```

### Submit and bash
#### Submit a workload with bash command

```shell

runai training pytorch submit  -p alon -i nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04 -g 1 --workers 3 --command -- bash -c 'trap : TERM INT; sleep infinity & wait'
```

#### bash into the workload
```shell

runai training pytorch bash pytorch-06027b585626 -p alon
```

### Submit MPI

```shell

runai  mpi submit dist1 --workers=2 -g 1 \
    -i runai.jfrog.io/demo/quickstart-distributed:v0.3.0 -e RUNAI_SLEEP_SECS=60 -p alon
```

### Submit with PVC
#### New PVC bounded to the workspace - will be deleted when the workload is deleted
```shell

runai workspace submit -i ubuntu --new-pvc claimname=yuval-3,size=10M,path=/tmp/test
```
#### New ephemeral PVC - will deleted when the workload is deleted or paused
```shell

runai workspace submit -i ubuntu --new-pvc claimname=yuval2,size=10M,path=/tmp/test,ephemeral
```
#### Existing PVC - will not deleted when the workload is deleted
```shell
runai workspace submit -i ubuntu --existing-pvc claimname=test-pvc-2-project-mn2xs,path=/home/test
```

### Msster/Worker configuration


--command flag and -- are setting both leader(master) and workers command/arguments

--master-args flag sets the master arguments

--master-command flag set the master commands with arguments

--master-args and --master-command flags can set together


#### Override both the leader(master) and worker image's arguments
```shell
runai pytorch submit -i ubuntu -- -a argument_a -b argument_b -c
```
#### Override both the leader(master) and worker image's commands with arguments
```shell
runai pytorch submit -i ubuntu --command -- python -m pip install
```
#### Override arguments of the leader(master) and worker image's arguments with different values
```shell
runai pytorch submit -i ubuntu --master-args "-a master_arg_a -b master-arg_b'" -- '-a worker_arg_a'
```
#### Override command with arguments of the leader(master) and worker image's arguments
```shell
runai pytorch submit -i ubuntu --master-command "python_master -m pip install'" --command -- 'python_worker -m pip install'
```

## List objects
### Listing all workloads in the user's scope
```shell
runai workload list -A
```

### Listing projects in a YAML format
```shell

runai project list --yaml
```

### Listing nodes in a JSON format
```shell
runai node list --json
```

## CLI reference
For the full guide of the CLI syntax, see the [CLI reference](/saas/docs/cli-reference)

