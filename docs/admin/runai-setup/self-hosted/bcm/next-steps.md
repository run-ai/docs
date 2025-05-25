# Next Steps

## Restrict System Node Scheduling (Post-Installation)

After installation, you can configure NVIDIA Run:ai to enforce stricter scheduling rules that ensure system components and workloads are assigned to the correct nodes. The following flags are set using the `runaiconfig`. See [Advanced Cluster Configurations](../../../config/advanced-cluster-config.md) for more details.

1. Set `global.NodeAffinity.RestrictRunAISystem=true`. This ensures that NVIDIA Run:ai system components are scheduled only on nodes labeled as system nodes:

2. Set `global.nodeAffinity.restrictScheduling=true`. This prevents pure CPU workloads from being scheduled on GPU nodes. 

 