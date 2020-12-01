# Use a Jupyter Notebook with a Run:AI Job

Once you launch a workload using Run:AI, you will want to connect to it. You can do so via command-line or via other tools such as a [Jupyter Notebook](../Walkthroughs/walkthrough-build-ports.md)

This document is about accessing the remote container created by Run:AI via such a notebook.


## Submit a Workload

Run the following command to connect to the Jupyter Notebook container as if it were running local:

```
runai submit build-jupyter --jupyter -g 1
```

The terminal will show the following: 

``` shell
~> runai submit build-jupyter --jupyter -g 1
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

