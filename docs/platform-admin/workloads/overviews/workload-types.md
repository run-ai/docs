# Run:ai Workload Types

In the world of machine learning (ML), the journey from raw data to actionable insights is a complex process that spans multiple stages. Each stage of the AI lifecycle requires different tools, resources, and frameworks to ensure optimal performance. Run:ai simplifies this process by offering specialized workload types tailored to each phase, facilitating a smooth transition across various stages of the ML workflows. 

The ML lifecycle usually begins with the experimental work on data and exploration of different modeling techniques to identify the best approach for accurate predictions. At this stage, resource consumption is usually moderate as experimentation is done on a smaller scale. As confidence grows in the model's potential and its accuracy, the demand for compute resources increases. This is especially true during the training phase, where vast amounts of data need to be processed, particularly with complex models such as large language models (LLMs), with their huge parameter sizes, that often require distributed training across multiple GPUs to handle the intensive computational load. 

Finally, once the model is ready, it moves to the inference stage, where it is deployed to make predictions on new, unseen data. Run:ai's workload types are designed to correspond with the natural stages of this lifecycle. They are structured to align with the specific resource and framework requirements of each phase, ensuring that AI researchers and data scientists can focus on advancing their models without worrying about infrastructure management.

Run:ai offers three workload types that correspond to a specific phase of the researcher’s work:

* __Workspaces__ – For experimentation with data and models.
* __Training__ – For resource-intensive tasks such as model training and data preparation.
* __Inference__ – For deploying and serving the trained model.

## Workspaces: the experimentation phase

The __Workspace__ is where data scientists conduct initial research, experiment with different data sets, and test various algorithms. This is the most flexible stage in the ML lifecycle, where models and data are explored, tuned, and refined. The value of workspaces lies in the flexibility they offer, allowing the researcher to iterate quickly without being constrained by rigid infrastructure.  

* __Framework flexibility__
    
    Workspaces support a variety of machine learning frameworks, as researchers need to experiment with different tools and methods. 

* __Resource requirements__

    Workspaces are often lighter on resources compared to the training phase, but they still require significant computational power for data processing, analysis, and model iteration. 

    Hence, the default for the Run:ai workspaces considerations is to allow scheduling those workloads without the ability to preempt them once the resources were allocated. However, this non-preemptable state doesn’t allow to utilize more resources outside of the project’s deserved quota. 

See [Running workspaces](../../../Researcher/workloads/workspaces/workspace-v2.md) to learn more about how to submit a workspace via the Run:ai platform. For quick starts, see [Running Jupyter Notebook using workspaces](../../../Researcher/workloads/workspaces/quickstart-jupyter.md).

## Training: scaling resources for model development

As models mature and the need for more robust data processing and model training increases, Run:ai facilitates this shift through the Training workload. This phase is resource-intensive, often requiring distributed computing and high-performance clusters to process vast data sets and train models.

* __Training architecture__
    
    For training workloads Run:ai allows you to specify the architecture - standard or distributed. The distributed architecture is relevant for larger data sets and more complex models that require utilizing multiple nodes. For the distributed architecture, Run:ai allows you to specify different configurations for the master and workers and select which framework to use -  PyTorch, XGBoost, MPI, and TensorFlow. In addition, as part of the distributed configuration, Run:ai enable the researchers to schedule their distributed workloads on nodes within the same region, zone, placement group, or any other topology.

* __Resource requirements__

    Training tasks demand high memory, compute power, and storage. Run:ai ensures that the allocated resources match the scale of the task and allows those workloads to utilize more compute resources than the project’s deserved quota. Make sure that if you wish your training workload not to be preempted, specify the number of GPU’s that are in your quota.  


See [Standard training](../../../Researcher/workloads/training/standard-training/trainings-v2.md) and [Distributed training](../../../Researcher/workloads/training/distributed-training/distributed-training.md) to learn more about how to submit a training workload via the Run:ai UI. For quick starts, see [Run your first standard training](../../../Researcher/workloads/training/standard-training/quickstart-standard-training.md) and [Run your first distributed training](../../../Researcher/workloads/training/distributed-training/quickstart-distributed-training.md). 

!!! Note
    Multi-GPU training and distributed training are two distinct concepts. Multi-GPU training uses multiple GPUs within a single node, whereas distributed training spans multiple nodes and typically requires coordination between them.

## Inference: deploying and serving models

Once a model is trained and validated, it moves to the Inference stage, where it is deployed to make predictions (usually in a production environment). This phase is all about efficiency and responsiveness, as the model needs to serve real-time or batch predictions to end-users or other systems.

* __Inference-specific use cases__

    Naturally, inference workloads are required to change and adapt to the ever-changing demands to meet SLA. For example, additional replicas may be deployed, manually or automatically, to increase compute resources as part of a horizontal scaling approach or a new version of the deployment may need to be rolled out without affecting the running services.

* __Resource requirements__

    Inference models differ in size and purpose, leading to varying computational requirements. For example, small OCR models can run efficiently on CPUs, whereas LLMs typically require significant GPU memory for deployment and serving. Inference workloads are considered production-critical and are given the highest priority to ensure compliance with SLAs. Additionally, Run:ai ensures that inference workloads cannot be preempted, maintaining consistent performance and reliability.

See [Deploy a custom inference workload](../../../Researcher/workloads/inference/custom-inference.md) to learn more about how to submit an inference workload via the Run:ai UI. 

