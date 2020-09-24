# Installing Run:AI over network file storage

## Introduction

Run:AI is storaging data on a filesystem. How this storage is managed differs according to the customer environment and usage.

When the installation is for production purposes, then it is a good practice to setup the system such that if one node is down, the Run:AI software will seamlessly migrate to another node. For this, the storage has to reside on shared storage

The Run:AI cluster installation is performed by accessing the Administrator User Interface at [app.run.ai](https://app.run.ai/) downloading a YAML file ``runai-operator.yaml`` and then applying it to Kubernetes. You must edit the YAML file. Search for _nfs_

``` yaml
nfs:
    enabled: true
    server: <IP-address>
    path: /path/to/folder
``` 

Set _enabled_ to true and provide the NFS IP Address and an __existing__ folder that Run:AI can use. 