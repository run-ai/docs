
Below is a set of Quickstart documents. The purpose of these documents is to get you acquainted with an aspect of Run:ai in the simplest possible form.

!!! Note
    The Quickstart documents are based solely on the command-line interface. The same functionality can be achieved by using the [Workloads](../user-interface/workspaces/overview.md) User interface which allows for Workload submission and log viewing. 


Follow the Quickstart documents below to learn more:

* Training Quickstart documents:
    * [Unattended training sessions](walkthrough-train.md)
    * [Distributed Training](walkthrough-distributed-training.md)
* Build Quickstart documents: 
    * [Basic Interactive build sessions](walkthrough-build.md)
    * [Interfactive build session with connected ports](walkthrough-build-ports.md)
    * [Jupyter Notebook](quickstart-jupyter.md)
    * [Visual Studio Web](quickstart-vscode.md)
* [Inference](quickstart-inference.md)
* GPU Allocation documents:
    * [Using GPU Fractions](walkthrough-fractions.md)
    * [Dynamic MIG](quickstart-mig.md)
* Scheduling documents:
    * [Over-Quota, Basic Fairness & Bin Packing](walkthrough-overquota.md)
    * [Fairness](walkthrough-queue-fairness.md)

Most quickstarts rely on an image called `gcr.io/run-ai-demo/quickstart`. The image is based on  [TensorFlow Release 20-08](https://docs.nvidia.com/deeplearning/frameworks/tensorflow-release-notes/rel_20-08.html). This TensorFlow image has minimal requirements for _CUDA_ and _NVIDIA Compute Capability_. 

If your GPUs do not meet these requirements, use `gcr.io/run-ai-demo/quickstart:legacy` instead. 

 