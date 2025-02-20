# CLI examples

This article provides examples of popular use cases illustrating how to use the Command Line Interface (CLI)

### Logging in

#### Logging in via run:ai sign in page (web)

You can log in from the UI, if you are using SSO or credentials

```shell
runai login
```

#### Logging in via terminal (credentials)

```shell
runai login user -u john@acme.com -p "password"
```

### Configuration

#### Setting a default project

```shell
runai project set "project-name"
```

### Submitting a workload

#### Naming a workload

Use the commands below to provide a name for a workload.

**Setting a the workload name ( my\_workload\_name)**

```shell
runai workspace submit my-workload-name -p test -i ubuntu 
```

**Setting a random name with prefix (prefix=workload type)**

```shell
    runai workspace submit -p test -i ubuntu 
```

**Setting a random name with specific prefix (prefix determined by flag)**

```shell
runai workspace submit --prefix-name my-prefix-workload-name -p test -i ubuntu 
```

#### Labels and annotations

**Labels**

```shell
runai workspace submit -p test -i ubuntu --label name=value --label name2=value2
```

**Annotations**

```shell
runai workspace submit -p test -i ubuntu --annotation name=value --annotation name2=value2
```

#### Container's environment variables

```shell
runai workspace submit -p test -i ubuntu -e name=value -e name2=value2
```

#### Requests and limits

```shell
runai workspace submit  -p "project-name" -i runai.jfrog.io/demo/quickstart-demo   --cpu-core-request 0.3 --cpu-core-limit 1 --cpu-memory-request 50M --cpu-memory-limit 1G  --gpu-devices-request 1 --gpu-memory-request 1G
```

#### Submitting and attaching to process

```shell
runai workspace submit  -p "project-name" -i python  --attach -- python3
```

#### Submitting a jupyter notebook

```shell
runai workspace submit --image jupyter/scipy-notebook -p "project-name" --gpu-devices-request 1 --external-url container=8888 --name-prefix jupyter --command -- start-notebook.sh --NotebookApp.base_url='/${RUNAI_PROJECT}/${RUNAI_JOB_NAME}' --NotebookApp.token=''
```

#### Submitting distributed training workload with TensorFlow

```shell
runai distributed submit -f TF --workers=5 --no-master -g 1 -i kubeflow/tf-mnist-with-summaries:latest -p "project-name" --command -- python /var/tf_mnist/mnist_with_summaries.py --max_steps 1000000
```

#### Submitting a multi-pod workload

```shell

runai training submit  -i alpine -p test --parallelism 2 --completions 2  -- sleep 100000
```

#### Submit and bash

**Submitting a workload with bash command**

```shell

runai training pytorch submit  -p "project-name" -i nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04 -g 1 --workers 3 --command -- bash -c 'trap : TERM INT; sleep infinity & wait'
```

**Bashing into the workload**

```shell

runai training pytorch bash pytorch-06027b585626 -p "project-name"
```

#### Submitting distributed training workload with MPI

```shell

runai  mpi submit dist1 --workers=2 -g 1 \
    -i runai.jfrog.io/demo/quickstart-distributed:v0.3.0 -e RUNAI_SLEEP_SECS=60 -p "project-name"
```

#### Submitting with PVC

**New PVC bounded to the workspace**

New PVCs will be deleted when the workload is deleted

```shell

runai workspace submit -i ubuntu --new-pvc claimname=yuval-3,size=10M,path=/tmp/test
```

**New ephemeral PVC**

New ephemeral PVCs will be deleted when the workload is deleted or paused

```shell

runai workspace submit -i ubuntu --new-pvc claimname=yuval2,size=10M,path=/tmp/test,ephemeral
```

**Existing PVC**

Existing PVCs will not be deleted when the workload is deleted

```shell
runai workspace submit -i ubuntu --existing-pvc claimname=test-pvc-2-project-mn2xs,path=/home/test
```

#### Master/Worker configuration

\--command flag and -- are set both leader (master) and workers command/arguments

\--master-args flag sets the master arguments

\--master-command flag sets the master commands with arguments

\--master-args and --master-command flags can be set together

**Overriding both the leader (master) and worker image's arguments**

```shell
runai pytorch submit -i ubuntu -- -a argument_a -b argument_b -c
```

**Overriding both the leader (master) and worker image's commands with arguments**

```shell
runai pytorch submit -i ubuntu --command -- python -m pip install
```

**Overriding arguments of the leader (master) and worker image's arguments with different values**

```shell
runai pytorch submit -i ubuntu --master-args "-a master_arg_a -b master-arg_b'" -- '-a worker_arg_a'
```

**Overriding command with arguments of the leader (master) and worker image's arguments**

```shell
runai pytorch submit -i ubuntu --master-command "python_master -m pip install'" --command -- 'python_worker -m pip install'
```



#### Submitting with environment variables

Submitting with a secret as an environment variable

```
runai 
```

### Listing objects

#### Listing all workloads in the user's scope

```shell
runai workload list -A
```

#### Listing projects in a YAML format

```shell

runai project list --yaml
```

#### Listing nodes in a JSON format

```shell
runai node list --json
```

### CLI reference

For the full guide of the CLI syntax, see the [CLI reference](../../docs/cli-reference/)
