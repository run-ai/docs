# Hyperparameter Optimization using Run:ai and SigOpt

This is an example of how to run hyperparameter tuning on a Run:ai cluster with SigOpt platform. 

We use master.py to launch pods on the Run:ai cluster. Each pod downloads and runs remote.sh and remote.py, connecting to the SigOpt platform to extract a set of hyperparameters to evaluate through model training. When training ends, each pod reconnects to the SigOpt platform to report back the results. 

## Usage
Follow the Run:ai quickstart to [launch training workloads](https://docs.run.ai/Researcher/Walkthroughs/walkthrough-train/) on a Run:ai cluster.

Plug in your SigOpt client token to master.py and remote.py.

Place remote.sh and remote.py on a shared storage. 

Change master.py and remote.sh to point to where remote.sh and remote.py are located in the shared storage (they currently assume a shared storage on Google Cloud). 

Run in your local machine
```
python master.py --job_name my-exp-name --parallel_jobs 4 --observation_budget 32 --project my-runai-project-name
``` 
The script will tune a [simple model](https://github.com/sigopt/sigopt-python) with two hyperparameters. Run:ai will keep spinning up and orchestrating 4 parallel pods, each connecting to the SigOpt platform and training the model with a different set of hyperparameters, until 32 pods are completed successfully. 
