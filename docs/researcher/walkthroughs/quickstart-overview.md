
Below are a set of Quickstart documents. The purpose of these documents is to get you acquainted with an aspect of Run:ai in the simplest possible form.
Follow the Quickstart documents below to learn more:

* [Unattended training sessions](walkthrough-train.md)
* [Interactive build sessions](walkthrough-build.md)
* [Interactive build sessions with externalized services](walkthrough-build-ports.md)
* [Using GPU Fractions](walkthrough-fractions.md)
* [Distributed Training](walkthrough-distributed-training.md)
* [Hyperparameter Optimization](walkthrough-hpo.md)
* [Over-Quota, Basic Fairness & Bin Packing](walkthrough-overquota.md)
* [Fairness](walkthrough-queue-fairness.md)
* [Inference](quickstart-inference.md)
* [Dynamic MIG](quickstart-mig.md)

Most quickstarts rely on an image called `gcr.io/run-ai-demo/quickstart`. The image is based on  [TensorFlow Release 20-08](https://docs.nvidia.com/deeplearning/frameworks/tensorflow-release-notes/rel_20-08.html). This TensorFlow image has minimal requirements for _CUDA_ and _NVIDIA Compute Capability_. 

If your GPUs do not meet these requirements, use `gcr.io/run-ai-demo/quickstart:legacy` instead. 

 