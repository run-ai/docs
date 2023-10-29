# Deleting a Cluster Installation


To delete a Run:ai Cluster installation while retaining existing running jobs, run the following commands:



=== "Version 2.9 or later"
    ```
    helm delete runai-cluster -n runai
    ``` 

=== "Version 2.8"
    ```
    kubectl delete RunaiConfig runai -n runai
    helm delete runai-cluster -n runai
    ```

=== "Version 2.7 or earlier"
    ```
    kubectl patch RunaiConfig runai -n runai -p '{"metadata":{"finalizers":[]}}' --type="merge"
    kubectl delete RunaiConfig runai -n runai
    helm delete runai-cluster runai -n runai
    ```

The commands will __not__ delete existing Jobs submitted by users. 

