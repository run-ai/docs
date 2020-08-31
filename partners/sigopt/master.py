from sigopt import Connection
from sigopt.examples import franke_function
import subprocess
import time
import argparse

# parse input arguments
parser = argparse.ArgumentParser(description='Hyper parameter optimization.')
parser.add_argument('--job_name', type=str, default='hpo',
                    help='job name')
parser.add_argument('--parallel_jobs', type=int, default='1',
                    help='Number of parallel jobs')
parser.add_argument('--observation_budget', type=int, default='32',
                    help='Number of observations')
parser.add_argument('--project', type=str, default='team-sf',
                    help='Runai project')
                
args = parser.parse_args()

job_name = str(args.job_name)
parallel_bandwidth = args.parallel_jobs
observation_budget = args.observation_budget
project = str(args.project)

# plug in your SigOpt client token here
conn = Connection(client_token=<your-token>)

# create a new SigOpt experiment 
experiment = conn.experiments().create(
  name=job_name + "-" + str(parallel_bandwidth) + "-parallel-jobs",
  # define the parameters to tune
  parameters=[
    dict(name='x', type='double', bounds=dict(min=0.0, max=1.0)),
    dict(name='y', type='double', bounds=dict(min=0.0, max=1.0)),
  ],
  metrics=[dict(name='function_value', objective='maximize')],
  parallel_bandwidth=parallel_bandwidth,
  observation_budget=observation_budget,
  project="sigopt-examples",
)
print("Created experiment: https://app.sigopt.com/experiment/" + experiment.id)

# change the following command to point to where remote.sh is located in your shared storage (now assuming Google Storage)
# the command will launch multiple pods on the Run:AI cluster
subprocess.call(["runai","submit",job_name + "-" + str(run_count),"--image","gcr.io/run-ai-demo/quickstart",
                "--parallelism",parallel_bandwidth,"--completions",observation_budget,
                "--project",project,"-g", "1", "--command","/bin/bash","--command","-c",
                "--command","wget https://storage.googleapis.com/remote.sh && chmod 0755 ./remote.sh && ./remote.sh",
                "--environment","EXP_ID=" + str(experiment.id)])