
Deep learning workloads can be divided into two generic types:

*   Interactive "build" sessions. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter notebook, remote PyCharm, or similar and accesses GPU resources directly . Build workloads typically do not maximize usage of the GPU. 
*   Unattended "training" sessions. Training is characterized by a deep learning run that has a start and a finish. With these types of workloads, the data scientist prepares a self-running workload and sends it for execution. During the execution, the customer can examine the results . A Training session can take from a few minutes to a couple of days. It can be interrupted in the middle and later restored (though the data scientist should save checkpoints for that purpose). Training workloads typically utilize large percentages of the GPU. 

Follow a Walk-through for each using the links below

*   [Unattended training sessions](walkthrough-train.md)
*   [Interactive build sessions](walkthrough-build.md)
*   [Interactive build sessions with externalized services](walkthrough-build-ports.md)
*   [Using GPU Fractions](walkthrough-fractions.md)
*   [Distributed Training](walkthrough-distributed-training.md)
*   [Hyperparameter Optimization](walkthrough-hpo.md)
*   [Over-Quota, Basic Fairness & Bin Packing](walkthrough-overquota.md)
*   [Fairness](walkthrough-queue-fairness.md)
*   [Elasticity](walkthrough-elasticity.md)