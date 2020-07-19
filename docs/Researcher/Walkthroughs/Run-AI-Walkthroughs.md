&nbsp;

Deep learning workloads can be divided into two generic types:

*   Interactive "build" sessions. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter notebook, remote PyCharm, or similar and accesses GPU resources directly<span>. Build workloads typically do not maximize usage of the GPU.&nbsp;</span>
*   Unattended "training" sessions.&nbsp;<span>Training is characterized by a deep learning run that has a start and a finish&nbsp;</span>With these types of workloads, the data scientist prepares a self-running workload and sends it for execution. During the execution, the customer can examine the results<span>. A Training session can take from a few minutes to a couple of days. It can be interrupted in the middle and later restored (though the data scientist should save checkpoints for that purpose). Training workloads typically utilize large percentages of the GPU.</span>

Follow the Walkthroughs for each using the links below

*   Unattended training sessions:&nbsp;<https://support.run.ai/hc/en-us/articles/360010706360-Walkthrough-Launch-Unattended-Training-Workloads->
*   Interactive build sessions:&nbsp;<https://support.run.ai/hc/en-us/articles/360010894959-Walkthrough-Start-and-Use-Interactive-Build-Workloads->&nbsp;
*   Interactive build sessions with externalized services:&nbsp;<https://support.run.ai/hc/en-us/articles/360011131919-Walkthrough-Launch-an-Interactive-Build-Workload-with-Connected-Ports>
*   Using GPU Fractions:&nbsp;<https://support.run.ai/hc/en-us/articles/360014989740-Walkthrough-Using-GPU-Fractions>&nbsp;