# Overview: The Run:AI Researcher Library

## Introduction

Run:AI provides a python library that can optionally be installed within your docker image and activated during the deep learning session.   
When installed, the library provides:

*   Additional progress reporting and metrics
*   Ability to dynamically stretch and compress jobs according to GPU availability.
*   Support for experiment management when performing hyperparameter optimization

The library is open-source and can be reviewed [here](https://github.com/run-ai/runai).

## Installing the Run:AI Researcher Library

In your command-line run:

    pip install runai

## Run:AI Researcher Library Modules

To review details on the specific Run:AI Researcher Library modules see:

*   [Reporting via the Run:AI Researcher Library](rl-reporting.md)
*   [Elasticity, Dynamically Stretch/Compress Jobs According to GPU Availability](rl-elasticity.md)
*   [Hyperparameter optimization support](rl-hpo-support.md) 