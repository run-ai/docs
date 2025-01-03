

This article explains the procedure to view and manage Clusters.

The Cluster table provides a quick and easy way to see the status of your cluster.

[](img/cluster-list.png)

## Clusters table

The Clusters table can be found under Clusters in the Run:ai platform.

The clusters table provides a list of the clusters added to Run:ai platform, along with their status.

The clusters table consists of the following columns:

| Column | Description |
| :---- | :---- |
| Cluster | The name of the cluster |
| Status | The status of the cluster. For more information see the table below. Hover over the information icon for a short description and links to troubleshooting |
| Creation time | The timestamp when the cluster was created |
| URL | The URL that was given to the cluster |
| Run:ai cluster version | The Run:ai version installed on the cluster |
| Kubernetes distribution | The flavor of Kubernetes distribution |
| Kubernetes version | The version of Kubernetes installed |
| Run:ai cluster UUID | The unique ID of the cluster |

### Customizing the table view

* Filter - Click ADD FILTER, select the column to filter by, and enter the filter values  
* Search - Click SEARCH and type the value to search by  
* Sort - Click each column header to sort by  
* Column selection - Click COLUMNS and select the columns to display in the table  
* Download table - Click MORE and then Click Download as CSV. Export to CSV is limited to 20,000 rows. 

### Cluster status

| Status | Description |
| :---- | :---- |
| Waiting to connect | The cluster has never been connected. |
| Disconnected | There is no communication from the cluster to the {{glossary.Control plane}}. This may be due to a network issue. [See the troubleshooting scenarios.](#troubleshooting-scenarios) |
| Missing prerequisites | Some prerequisites are missing from the cluster. As a result, some features may be impacted. [See the troubleshooting scenarios.](#troubleshooting-scenarios) |
| Service issues | At least one of the services is not working properly. You can view the list of nonfunctioning services for more information. [See the troubleshooting scenarios.](#troubleshooting-scenarios) |
| Connected | The Run:ai cluster is connected, and all Run:ai services are running. |

## Adding a new cluster

To add a new cluster see the installation guide.

## Removing a cluster

1. Select the cluster you want to remove  
2. Click __REMOVE__
3. A dialog appears: Make sure to carefully read the message before removing  
4. Click __REMOVE__ to confirm the removal.

### Using the API

Go to the [Clusters](https://app.run.ai/api/docs#tag/Clusters) API reference to view the available actions

## Troubleshooting

Before starting, make sure you have the following:

* Access to the Kubernetes cluster where Run:ai is deployed with the necessary permissions  
* Access to the Run:ai Platform

### Troubleshooting scenarios

??? "Cluster disconnected"
    __Description__: When the cluster's status is ‘disconnected’, there is no communication from the cluster services reaching the Run:ai Platform. This may be due to networking issues or issues with Run:ai services.

    __Mitigation__:

    1. Check Run:ai’s services status: 

        * Open your terminal  
        * Make sure you have access to the Kubernetes cluster with permission to view pods  
        * Copy and paste the following command to verify that Run:ai’s services are running:  

        ``` bash
        kubectl get pods -n runai | grep -E 'runai-agent|cluster-sync|assets-sync'
        ```
        * If any of the services are not running, see the ‘cluster has service issues’ scenario.  

    2. Check the network connection  
        * Open your terminal  
        * Make sure you have access to the Kubernetes cluster with permissions to create pods  
        * Copy and paste the following command to create a connectivity check pod:  

        ``` bash
        kubectl run control-plane-connectivity-check -n runai --image=wbitt/network-multitool \
            --command -- /bin/sh -c 'curl -sSf <control-plane-endpoint> > /dev/null && echo "Connection Successful" \
            || echo "Failed connecting to the Control Plane"'
        ```

        * Replace `<control-plane-endpoint>` with the URL of the Control Plane in your environment. If the pod fails to connect to the Control Plane, check for potential network policies 

    3. Check and modify the network policies

        * Open your terminal  
        * Copy and paste the following command to check the existence of network policies:  
        ``` bash
        kubectl get networkpolicies -n runai
        ```

        * Review the policies to ensure that they allow traffic from the Run:ai namespace to the Control Plane. If necessary, update the policies to allow the required traffic.
        Example of allowing traffic:
         
        ``` YAML
        apiVersion: networking.k8s.io/v1
        kind: NetworkPolicy
        metadata:
        name: allow-control-plane-traffic
        namespace: runai
        spec:
        podSelector:
            matchLabels:
            app: runai
        policyTypes:
            - Ingress
            - Egress
        egress:
            - to:
                - ipBlock:
                    cidr: <control-plane-ip-range>
            ports:
                - protocol: TCP
                port: <control-plane-port>
        ingress:
            - from:
                - ipBlock:
                    cidr: <control-plane-ip-range>
            ports:
                - protocol: TCP
                port: <control-plane-port>
        ```

        *  Check infrastructure-level configurations: 

            * Ensure that firewall rules and security groups allow traffic between your Kubernetes cluster and the Control Plane  
            * Verify required ports and protocols:  
                * Ensure that the necessary ports and protocols for Run:ai’s services are not blocked by any firewalls or security groups  

    4. Check Run:ai services logs  
        * Open your terminal  
        * Make sure you have access to the Kubernetes cluster with permissions to view logs  
        * Copy and paste the following commands to view the logs of the Run:ai services: 

        ``` bash
        kubectl logs deployment/runai-agent -n runai
        kubectl logs deployment/cluster-sync -n runai
        kubectl logs deployment/assets-sync -n runai
        ```

        * Try to identify the problem from the logs. If you cannot resolve the issue, continue to the next step. 

    5. Contact Run:ai’s support  
        * If the issue persists, [contact Run:ai’s support](../../home/overview.md#how-to-get-support) for assistance.

??? "Cluster has service issues"
    __Description__: When a cluster's status is _Has service issues_, it means that one or more Run:ai services running in the cluster are not available.

    __Mitigation__:

    1. Verify non-functioning services  

        * Open your terminal  
        * Make sure you have access to the Kubernetes cluster with permissions to view the `runaiconfig` resource  
        * Copy and paste the following command to determine which services are not functioning:  

        ```bash
        kubectl get runaiconfig -n runai runai -ojson | jq -r '.status.conditions | map(select(.type == "Available"))'
        ```

    2. Check for Kubernetes events 
     
        * Open your terminal  
        * Make sure you have access to the Kubernetes cluster with permissions to view events  
        * Copy and paste the following command to get all [Kubernetes events](https://kubernetes.io/docs/reference/kubernetes-api/cluster-resources/event-v1/):  
 
    3. Inspect resource details  

        * Open your terminal  
        * Make sure you have access to the Kubernetes cluster with permissions to describe resources  
        * Copy and paste the following command to check the details of the required resource:  

        ```bash
        kubectl describe <resource_type> <name>
        ```

    4. Contact Run:ai’s Support  
        * If the issue persists, contact [contact Run:ai’s support](../../home/overview.md#how-to-get-support) for assistance.

??? "Cluster is waiting to connect"
    __Description__: When the cluster's status is ‘waiting to connect’, it means that no communication from the cluster services reaches the Run:ai Platform. This may be due to networking issues or issues with Run:ai services.

    __Mitigation__:

    1. Check Run:ai’s services status 

        * Open your terminal  
        * Make sure you have access to the Kubernetes cluster with permissions to view pods  
        * Copy and paste the following command to verify that Run:ai’s services are running:  

        ``` bash
        kubectl get pods -n runai | grep -E 'runai-agent|cluster-sync|assets-sync'
        ```

        * If any of the services are not running, see the ‘cluster has service issues’ scenario. 

    2. Check the network connection 

        * Open your terminal  
        * Make sure you have access to the Kubernetes cluster with permissions to create pods  
        * Copy and paste the following command to create a connectivity check pod:  

        ```bash
        kubectl run control-plane-connectivity-check -n runai --image=wbitt/network-multitool --command -- /bin/sh -c 'curl -sSf <control-plane-endpoint> > /dev/null && echo "Connection Successful" || echo "Failed connecting to the Control Plane"'
        ```

        * Replace `<control-plane-endpoint>` with the URL of the Control Plane in your environment. If the pod fails to connect to the Control Plane, check for potential network policies:  

    3. Check and modify the network policies  
   
        * Open your terminal  
        * Copy and paste the following command to check the existence of network policies:  

        ```bash
        kubectl get networkpolicies -n runai
        ```

        * Review the policies to ensure that they allow traffic from the Run:ai namespace to the Control Plane. If necessary, update the policies to allow the required traffic. 
        Example of allowing traffic:  
 
        ```yaml
        apiVersion: networking.k8s.io/v1
        kind: NetworkPolicy
        metadata:
        name: allow-control-plane-traffic
        namespace: runai
        spec:
          podSelector:
            matchLabels:
            app: runai
          policyTypes:
            - Ingress
            - Egress
          egress:
            - to:
                - ipBlock:
                    cidr: <control-plane-ip-range>
            ports:
                - protocol: TCP
                port: <control-plane-port>
          ingress:
            - from:
                - ipBlock:
                    cidr: <control-plane-ip-range>
            ports:
                - protocol: TCP
                port: <control-plane-port>
        ```

        * Check infrastructure-level configurations:  
        * Ensure that firewall rules and security groups allow traffic between your Kubernetes cluster and the Control Plane  
        * Verify required ports and protocols:  
            * Ensure that the necessary ports and protocols for Run:ai’s services are not blocked by any firewalls or security groups 

    4. Check Run:ai services logs  
        * Open your terminal  
        * Make sure you have access to the Kubernetes cluster with permission to view logs  
        * Copy and paste the following commands to view the logs of the Run:ai services:  

        ``` bash
        kubectl logs deployment/runai-agent -n runai
        kubectl logs deployment/cluster-sync -n runai
        kubectl logs deployment/assets-sync -n runai
        ```

        * Try to identify the problem from the logs. If you cannot resolve the issue, continue to the next step  
    
    5. Contact Run:ai’s support  
        * If the issue persists, [contact Run:ai’s support](../../home/overview.md#how-to-get-support) for assistance.

??? "Cluster is missing prerequisites"
    __Description__: When a cluster's status displays Missing prerequisites, it indicates that at least one of the Mandatory Prerequisites has not been fulfilled. In such cases, Run:ai services may not function properly.

    __Mitigation__:

    If you have ensured that all prerequisites are installed and the status still shows *missing prerequisites*, follow these steps:

    1. Check the message in the Run:ai platform for further details regarding the missing prerequisites.  
    2. Inspect the `runai-public` ConfigMap:  

        * Open your terminal. In the terminal, type the following command to list all ConfigMaps in the `runai` namespace: 

        ```bash
        kubectl get configmap -n runai
        ```

    3. Describe the ConfigMap  
        * Locate the ConfigMap named `runai-public` from the list  
        * To view the detailed contents of this ConfigMap, type the following command:  

        ``` bash
        kubectl describe configmap runai-public -n runai
        ```

    4. Find Missing Prerequisites  
        * In the output displayed, look for a section labeled `dependencies.required`  
        * This section provides detailed information about any missing resources or prerequisites. Review this information to identify what is needed  

    5. Contact Run:ai’s support  
        * If the issue persists, [contact Run:ai’s support](../../home/overview.md#how-to-get-support) for assistance.

