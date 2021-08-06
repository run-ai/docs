## Cluster Installation

Perform the cluster installation instructions explained [here](../../runai-setup/cluster-setup/cluster-install/#step-3-install-runai). 

* When creating a new cluster on step 3, select __OpenShift__ as the target platform.
* Make the following changes to the YAML file:


|  Key     |  Change  | Description |
|----------|----------|-------------| 
| `runai-operator.config.project-controller.createNamespaces` |  `true` | Set to `false` if unwilling to provide Run:AI the ability to create namespaces, or would want to create namespaces manually rather than use the Run:AI convention of `runai-<PROJECT-NAME>`. When set to `false`, will require an additional [manual step](project-management.md) when creating new Run:AI Projects. | 
| `runai-operator.config.project-controller.createRoleBindings` |  `true` | Automatically assign Users to Projects. Set to `false` if unwilling to provide Run:AI the ability to set _RoleBinding_. When set to `false`, will require an additional [manual step](project-management.md) when adding or removing users from Projects.  | 
| `runai-operator.config.mps-server.enabled` | Default is `false` | Allow the use of __NVIDIA MPS__. MPS is useful with _Inference_ workloads. Requires [extra permissions](../preparations/#cluster-installation) | 
| `runai-operator.config.runai-container-toolkit.enabled` | Default is `true` | Controls the usage of __Fractions__. Requires [extra permissions](../preparations/#cluster-installation) | 
| `runai-operator.config.runaiBackend.password` | Default password already set  | admin@run.ai password. Need to change only if you have changed the password [here](../backend/#other-changes-to-perform) | 




<!-- 
admission-controller:
  args:
    runaiFractionalMinAllocationEnforcementBytes: 1000000  
-->

Run:

=== "Airgapped"
    ```
    helm install runai-cluster -n runai  \ 
      runai-cluster-<version>.tgz -f runai-<cluster-name>.yaml  
    ```

=== "Connected"
    ```
    helm repo add runai https://run-ai-charts.storage.googleapis.com
    helm repo update

    helm install runai-cluster runai/runai-cluster -n runai \
        -f runai-<cluster-name>.yaml
    ```


!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. For more details see: [Understanding cluster access foles](../../runai-setup/cluster-setup/access-roles/).




## Next Steps

Continue to [create Run:AI Projects](project-management.md).
