
# Integrations with Run:ai

## Integration support

Support for third-party integrations varies. When noted below, the integration is supported out of the box with Run:ai. For other integrations, our Customer Success team has prior experience assisting customers with setup. In many cases, the NVIDIA Enterprise Support Portal may include additional reference documentation provided on an as-is basis.

## Integrations

| Tool               | Category        | Run:ai support details            | Additional Information|
| ------------------ | ----------------| --------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Triton             | Orchestration   | Supported   | Usage via docker base image. Quickstart inference [example](../../Researcher/Walkthroughs/quickstart-inference.md)  |
| Spark              | Orchestration   | Community Support |  <div style="width: 300px;"> It is possible to schedule Spark workflows with the Run:ai Scheduler. Sample code: [How to Run Spark job with Run:ai](https://enterprise-support.nvidia.com/s/article/How-to-Run-Spark-jobs-with-Run-AI){target=_blank}.    |
| Kubeflow Pipelines | Orchestration   | Community Support | It is possible to schedule kubeflow pipelines with the Run:ai Scheduler. Sample code: [How to integrate Run:ai with Kubeflow](https://enterprise-support.nvidia.com/s/article/How-to-integrate-Run-ai-with-Kubeflow){target=_blank}           |
| Apache Airflow     | Orchestration   | Community Support |It is possible to schedule Airflow workflows with the Run:ai Scheduler. Sample code: [How to integrate Run:ai with Apache Airflow](https://enterprise-support.nvidia.com/s/article/How-to-integrate-Run-ai-with-Apache-Airflow){target=_blank} |
| Argo workflows     | Orchestration   | Community Support | It is possible to schedule Argo workflows with the Run:ai Scheduler. Sample code: [How to integrate Run:ai with Argo Workflows](https://enterprise-support.nvidia.com/s/article/How-to-integrate-Run-ai-with-Argo-Workflows){target=_blank}  |
| SeldonX            | Orchestration   | Community Support |It is possible to schedule Seldon Core workloads with the Run:ai Scheduler. Sample code: [How to integrate Run:ai with Seldon Core](https://enterprise-support.nvidia.com/s/article/How-to-integrate-Run-ai-with-Seldon-Core){target=_blank}    |
| Jupyter Notebook   | Development     | Supported   | Run:ai provides integrated support with Jupyter Notebooks. Quickstart [example](../../Researcher/workloads/workspaces/quickstart-jupyter.md)  |
| Jupyter Hub        | Development     | Community Support | It is possible to submit Run:ai workloads via JupyterHub. Sample code: [How to connect JupyterHub with Run:ai](https://enterprise-support.nvidia.com/s/article/How-to-connect-JupyterHub-with-Run-ai){target=_blank}       |
| PyCharm            | Development     | Supported   | Containers created by Run:ai can be accessed via PyCharm. PyCharm [example](../../Researcher/tools/dev-pycharm.md)   |
| VScode             | Development     | Supported |  - Containers created by Run:ai can be accessed via Visual Studio Code. [example](../../Researcher/tools/dev-vscode.md) <br>- You can automatically launch Visual Studio code web from the Run:ai console. [example](../../Researcher/Walkthroughs/quickstart-vscode.md). |
| Kubeflow notebooks | Development     | Community Support | It is possible to schedule kubeflow notebooks with the Run:ai Scheduler. Sample code: [How to integrate Run:ai with Kubeflow](https://enterprise-support.nvidia.com/s/article/How-to-integrate-Run-ai-with-Kubeflow){target=_blank}      |
| Ray                | training, inference, data processing. | Community Support |It is possible to schedule Ray jobs with the Run:ai Scheduler. Sample code: [How to Integrate Run:ai with Ray](https://enterprise-support.nvidia.com/s/article/How-to-Integrate-Run-ai-with-Ray){target=_blank}   |
| TensorBoard        | Experiment tracking | Supported | Run:ai comes with a preset Tensorboard [Environment](../workloads/assets/environments.md) asset. TensorBoard [example](../../Researcher/tools/dev-tensorboard.md). <br> Additional [sample](https://github.com/run-ai/use-cases/tree/master/runai_tensorboard_demo_with_resnet){target=_blank} |
| Weights & Biases   | Experiment tracking | Community Support |It is possible to schedule W&B workloads with the Run:ai Scheduler. Sample code: [How to integrate with Weights and Biases](https://enterprise-support.nvidia.com/s/article/How-to-integrate-with-Weights-and-Biases){target=_blank} <br> Additional samples [here](https://github.com/run-ai/use-cases/tree/master/runai_wandb){target=_blank}       |
| ClearML            | Experiment tracking | Community Support | It is possible to schedule ClearML workloads with the Run:ai Scheduler. Sample code: [How to integrate Run:ai with ClearML](https://enterprise-support.nvidia.com/s/article/How-to-integrate-Run-ai-with-ClearML){target=_blank}                          |
| MLFlow             | Model Serving       | Community Support | It is possible to use ML Flow together with the Run:ai Scheduler. Sample code: [How to integrate Run:ai with MLFlow](https://enterprise-support.nvidia.com/s/article/How-to-integrate-Run-ai-with-MLflow){target=_blank} <br> Additional MLFlow [sample](https://github.com/run-ai/use-cases/tree/master/runai_mlflow_demo){target=_blank}              |
| Hugging Face       | Repositories    | Supported | Run:ai provides an out of the box integration with Hugging Face  |   
| Docker Registry    | Repositories    | Supported |  Run:ai allows using a docker registry as a [Credentials](../workloads/assets/credentials.md) asset.   |
| S3                 | Storage         | Supported | Run:ai communicates with S3 by defining a [data source](../workloads/assets/datasources.md) asset.   |
| Github             | Storage         | Supported | Run:ai communicates with GitHub by defining it as a [data source](../workloads/assets/datasources.md)  asset                        |
| Tensorflow         | Training        | Supported | Run:ai provides out of the box support for submitting TensorFlow workloads [via API](../../Researcher/cli-reference/new-cli/runai_tensorflow.md) or by submitting workloads [via user interface](../../Researcher/workloads/training/standard-training/trainings-v2.md).   |
| Pytorch            | Training        | Supported | Run:ai provides out of the box support for submitting PyTorch workloads [via API](../../Researcher/cli-reference/new-cli/runai_pytorch.md) or by submitting workloads [via user interface](../../Researcher/workloads/training/standard-training/trainings-v2.md).   |
| [Kubeflow MPI](https://www.kubeflow.org/docs/components/training/user-guides/mpi/){target=_blank}       | Training  |  Supported |Run:ai provides out of the box support for submitting MPI workloads [via API](../../Researcher/cli-reference/new-cli/runai_mpi.md) or by submitting workloads [via user interface](../../Researcher/workloads/training/standard-training/trainings-v2.md)    |
| [XGBoost](https://xgboost.readthedocs.io/en/stable/){target=_blank}            | Training                              | Supported | Run:ai provides out of the box support for submitting XGBoost workloads [via API](../../Researcher/cli-reference/new-cli/runai_xgboost.md) or by submitting workloads [via user interface](../../Researcher/workloads/training/standard-training/trainings-v2.md)    |
| [Karpenter](https://karpenter.sh){target=_blank} | Cost Optimization | Supported | Run:ai provides out of the box support for Karpenter to save cloud costs. Integration notes with Karpenter can be found [here](karpenter.md) | 

## Kubernetes Workloads Integration

Kubernetes has several built-in resources that encapsulate running *Pods*. These are called [Kubernetes Workloads](https://kubernetes.io/docs/concepts/workloads/){target=_blank} and **should not be confused** with Run:ai Workloads.

Examples of such resources are a *Deployment* that manages a stateless application, or a *Job* that runs tasks to completion.

Run:ai natively runs Run:ai Workloads. A Run:ai workload encapsulates all the resources needed to run, creates them, and deletes them together. However, Run:ai, being an **open platform** allows the scheduling of **any** Kubernetes Workflow.

For more information see [Kubernetes Workloads Integration](../../developer/other-resources/other-resources.md).

