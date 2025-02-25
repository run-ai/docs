# Welcome to Run:ai

At its core, Run:ai focuses on managing and optimizing various AI workloads, essentially the computational tasks data scientists and researchers run on a GPU-accelerated infrastructure. These workloads range from training complex neural networks to running  on deployed models, and each comes with its own set of  requirements and constraints.

The concept of workloads in Run:ai is fundamental to understanding how the platform operates and delivers value. By efficiently managing these workloads, Run:ai enables organizations to maximize the utilization of their expensive GPU resources, accelerate AI development cycles, and ultimately drive faster time-to-market for AI-powered innovations.

## Motivation, value, and use cases

The primary motivation behind Run:ai's workload management system is to address several key challenges faced by organizations in the AI/ML space:

## Efficient resource utilization

One of the most significant challenges in AI infrastructure management is to avoid the underutilization of GPU resources. Run:ai's workload management system aims to maximize GPU utilization by:

* Intelligent scheduling of workloads to available resources
* Dynamic allocation and reallocation of GPU fractions to match workload needs
* Queueing and prioritization mechanisms to ensure continuous resource usage

## Improved productivity for data scientists and researchers

AI researchers and data scientists often face bottlenecks due to limited access to computational resources or complex resource management processes. Run:ai addresses these issues in a number of different ways, including:


* The provision a simple interface to both submit and manage workloads
* Offering automatic resource allocation based on workload requirements
* Enabling easy scaling of experiments from single-GPU to multi-GPU or distributed computing setups

## Cost optimization

The high cost of AI infrastructure, particularly GPUs, makes cost optimization a crucial consideration for organizations. Run:ai's workload management contributes to cost savings through:

* Improved hardware utilization, reducing the need for additional GPU purchases
* Automation of resource allocation and minimizing manual intervention and management overheads
* Detailed analytics and reporting, enabling organizations to make data-driven decisions about resource provisioning

## Accelerated time-to-market

Quickly bringing AI-powered products and services to market can be a significant advantage. Run:ai's workload management accelerates development cycles by:

* Reducing wait times for computational resources
* Enabling faster experimentation and iteration on AI models
* Streamlining the transition from development to production environments

## Workloads in Run:ai

Run:ai is an open platform aiming to support and work with any type of k8s workload. We offer different levels of support for different types.

## Levels of support

Run:ai is an open platform and supports three tiers of workloads, each with a different set of features:

1. Run:ai native workloads (Training, Workspace, Inference)
2. Third-party integrations
3. Other Kubernetes workloads

See detailed information on the levels of support for each tier.

## Unified workload management

The updated Workloads UI consolidates all workloads into a single interface. The workload information is now updated in real-time with the Run:ai control plane, enhancing speed. It serves as a definitive source for all workload information, ensuring consistency throughout the application. In addition to run:ai workloads, any k8s workload can be overseen through run:ai workloads.





