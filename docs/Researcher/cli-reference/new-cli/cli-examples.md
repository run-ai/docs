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
