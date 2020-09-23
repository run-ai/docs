## Description

Set the current cluster
Show a list of available clusters

## Synopsis

``` shell
runai cluster set <cluster-name>
    [--loglevel value] 
    [--help | -h]

runai cluster list
    [--loglevel value] 
    [--help | -h]
```

## Options

<cluster-name\> the name of the cluster you want to set as current


### Global Flags

--loglevel (string)

> Set the logging level. One of: debug|info|warn|error (default "info")


--help | -h

>  Show help text

## Output

With these two commands you can show a __list__ of available clusters as well as to be able to set a __current__ cluster. The ``set`` command internally changes the default Kubernetes cluster

