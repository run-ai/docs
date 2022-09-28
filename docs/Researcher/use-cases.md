---
title: Use Cases
---
# Use Cases

This is a collection of various client-requested use-cases. Each use-case is accompanied by a short live-demo video, along with all the files used. As we learn more about our clients' specific needs, this page will be updated with new content. 
  
 !!! Note
	For the most up-to-date information, check out the official [run:ai use-cases](https://github.com/run-ai/use-cases){:target="_blank"} github page.  
  
+ [MLflow with run:ai](https://github.com/run-ai/use-cases/tree/master/runai_mlflow_demo){:target="_blank"}: experiment management is important for Data Scientist. This is a demo of how to set up and use mlflow with run:ai  
+ [Docker intro](https://github.com/run-ai/use-cases/tree/master/runai_docker_intro){:target="_blank"}: run:ai runs using Docker images. This is a (very) brief introduction to Docker, image creation, and how to use them in the context of run:ai. Please also check out the Persistent Environments use-case if you wish to keep the creation of Docker images to a minimum.  
+ [Tensorboard with Jupyter (ResNet demo)](https://github.com/run-ai/use-cases/tree/master/runai_tensorboard_demo_with_resnet){:target="_blank"}: Many Data Scientist like to use Tensorboard to keep an eye on the their current training experiments. They also like to have it side-by-side with Jupyter. In this demo, we will show how to integrate Tensorboard and Jupyter Lab within the context of run:ai.  
+ [Persistent Environments (with conda/mamba & Jupyter)](https://github.com/run-ai/use-cases/tree/master/runai_persist_envs){:target="_blank"}: Some Data Scientist find creating Docker images for every single one of their environments a bit of a hindrance. They would often prefer the ability to create and alter environments on the fly, and to have those environments remain, even after an image has finished running in a job. This demo shows users how they can create and persist conda/mamba environemnts using an NFS.  
+ [Weights & Biases with run:ai](https://github.com/run-ai/use-cases/tree/master/runai_wandb){:target="_blank"}: W&B is one of the best (if not the best) tools for experiment tracking and management, which is why run:ai is proud to have them as an official partner. In this tutorial, we'll demo how to use W&B alongside run:ai