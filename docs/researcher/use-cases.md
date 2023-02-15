---
title: Use Cases
---
# Use Cases

This is a collection of various client-requested use cases. Each use case is accompanied by a short live-demo video, along with all the files used.
  
!!! Note
	For the most up-to-date information, check out the official [Run:ai use-cases GitHub](https://github.com/run-ai/use-cases){:target="_blank"} page.  
  
+ [MLflow with Run:ai](https://github.com/run-ai/use-cases/tree/master/runai_mlflow_demo){:target="_blank"}: experiment management is important for Data Scientists. This is a demo of how to set up and use MLflow with Run:ai.  
+ [Introduction to Docker](https://github.com/run-ai/use-cases/tree/master/runai_docker_intro){:target="_blank"}: Run:ai runs using Docker images. This is a brief introduction to Docker, image creation, and how to use them in the context of Run:ai. Please also check out the Persistent Environments use case if you wish to keep the creation of Docker images to a minimum.  
+ [Tensorboard with Jupyter (ResNet demo)](https://github.com/run-ai/use-cases/tree/master/runai_tensorboard_demo_with_resnet){:target="_blank"}: Many Data Scientists like to use Tensorboard to keep an eye on the their current training experiments. They also like to have it side-by-side with Jupyter. In this demo, we will show how to integrate Tensorboard and Jupyter Lab within the context of Run:ai.  
+ [Persistent Environments (with Conda/Mamba & Jupyter)](https://github.com/run-ai/use-cases/tree/master/runai_persist_envs){:target="_blank"}: Some Data Scientists find creating Docker images for every single one of their environments a bit of a hindrance. They would often prefer the ability to create and alter environments on the fly and to have those environments remain, even after an image has finished running in a job. This demo shows users how they can create and persist Conda/Mamba environments using an NFS.  
+ [Weights & Biases with Run:ai](https://github.com/run-ai/use-cases/tree/master/runai_wandb){:target="_blank"}: W&B (Weights & Biases) is one of the best tools for experiment tracking and management. W&B is an official Run:ai partner. In this tutorial, we will demo how to use W&B alongside Run:ai