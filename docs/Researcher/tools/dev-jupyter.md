# Use a Jupyter Notebook with a Run:ai Job

A [Jupyter Notebook](https://jupyter.org){target=_blank} is an open-source web application that allows you to create and share documents that contain live code. Uses include data cleaning and transformation, numerical simulation, statistical modeling, data visualization, machine learning, and much more. Jupyter Notebooks are popular with Researchers as a way to code and run deep-learning code. A Jupyter Notebook __runs inside the user container__. 

This document is about accessing the remote container created by Run:ai via such a notebook. Alternatively, Run:ai provides integration with JupyterHub. [JupyterHub](https://jupyter.org/hub){target=_blank} is a __separate service__ that makes it possible to serve pre-configured data science environments. For more information see [Connecting JupyterHub with Run:ai](../../admin/integration/jupyterhub.md).


## Submit a Jupyter Notebook Workload

There are two ways to submit a Jupyter Notebook Job: via the Command-line interface or the user interface

## Submit via the User interface

* Within the user interface go to the Job list.
* Select `New Job` on the top right.
* Select `Interactive` at the top. 
* Add an image that supports Jupyter Notebook. For example `jupyter/scipy-notebook`.
* Select the `Jupyter Notebook` button.

Submit the Job. When running, select the job and press `Connect` on the top right.


## Submit a Workload

Run the following command to connect to the Jupyter Notebook container as if it were running locally:

```
runai submit build-jupyter --jupyter -g 1
```

The terminal will show the following: 

``` shell
~> runai submit build-jupyter --jupyter -g 1 --attach
INFO[0001] Exposing default jupyter notebook port 8888
INFO[0001] Using default jupyter notebook image "jupyter/scipy-notebook"
INFO[0001] Using default jupyter notebook service type portforward
The job 'build-jupyter' has been submitted successfully
You can run `runai describe job build-jupyter -p team-a` to check the job status
INFO[0006] Waiting for job to start
Waiting for job to start
Waiting for job to start
Waiting for job to start
Waiting for job to start
INFO[0081] Job started
Jupyter notebook token: 428dc561a5431bd383eff17714460de478d673deec57c045
Open access point(s) to service from localhost:8888
Forwarding from 127.0.0.1:8888 -> 8888
Forwarding from [::1]:8888 -> 8888
```

* The Job starts a Jupyter notebook container.
* The connection is redirected to the local machine (127.0.0.1) on port 8888


Browse to [http://localhost:8888](http://localhost:8888){target=_blank}. Use the token in the output to log into the notebook. 

## Alternatives

The above flag `--jupyter` is a shortcut with a predefined image. If you want to run your own notebook, use the quickstart on [running a build workload with connected ports](../Walkthroughs/walkthrough-build-ports.md). 

