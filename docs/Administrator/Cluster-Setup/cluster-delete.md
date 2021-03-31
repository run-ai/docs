# Deleting a Cluster Installation

To delete a Run:AI Cluster installation while retaining existing running jobs, run the following command:

``` 
 helm delete runai-cluster -n runai
 ```

The command will __not__ delete existing Jobs submitted by users. 

