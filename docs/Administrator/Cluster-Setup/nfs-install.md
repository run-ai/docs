# Installing Run:AI over network file storage

## Introduction

Run:AI is storing data on a filesystem. How this storage is configured differs according to the customer environment and usage:

When the purpose of the installation is a production environment, then it is a good practice to setup the system such that if one node is down, the Run:AI software will seamlessly migrate to another node. For this, the storage has to reside on shared storage

The Run:AI cluster installation is performed by accessing the Administrator User Interface at [app.run.ai](https://app.run.ai/) downloading a YAML file ``runai-operator.yaml`` and then applying it to Kubernetes. You must edit the YAML file before applying it to Kubernetes. 

Search for ``nfs``:

``` yaml
  nfs-client-provisioner:
    nfs:
      server:  <IP-address>
      path: /path/to/folder
  global:
    nfs:
      enabled: true
``` 


* Set ``enabled`` to true 
* Provide the  IP Address for the NFS server 
* Provide a path to an __existing__ folder that Run:AI can use. The folder should have read, write and execute permissions for all (``chmod 777 <folder-name>``).
