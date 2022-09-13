---
title: User-case Documentation Overview
---
# Overview: Use-cases Documentation

This is a collection of various client-requested use-cases. Each use-case is accompanied by a short live-demo video, and a link to a github repository for most use-cases. As we learn more about our clients' specific needs, this page will be updated with new content. 
  
+ [mlflow](./runai_mlflow_demo/README.md): **experiment management** is important for Data Scientist. This is a demo of how to set up and use mlflow with Run:ai
+ [Docker](./runai_docker_intro/README.md): Run:ai runs using Docker images. This is a (very) brief introduction to Docker, image creation, and how to use them in the context of Run:ai. Please also check out the Persistent Environments use-case if you wish to keep the creation of Docker images to a minimum.
+ [Tensorboard (with ResNet demo)](./runai_tensorboard_demo_with_resnet/README.md): Many Data Scientist like to use Tensorboard to keep an eye on the their current training experiments. They also like to have it side-by-side with Jupyter. In this demo, we will show how to integrate Tensorboard and Jupyter Lab within the context of Run:ai. 
+ [Persistent Environments (with conda/mamba & Jupyter)](./runai_persist_envs/README.md): Some Data Scientist find creating Docker images for every single one of their environments a bit of a hindrance. They would often prefer the ability to create and alter environments on the fly, and to have those environments remain, even after an image has finished running in a job. This demo shows users how they can create and persist conda/mamba environemnts using an NFS.