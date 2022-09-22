import seaborn as sns
import matplotlib.pyplot as plt
import mlflow
import os 
import time
from subprocess import Popen

# first we start the mlflow server
mlflow_command = 'mlflow server --backend-store-uri=sqlite:////home/jovyan/work/mlflow/mlflow.db --default-artifact-root=/home/jovyan/work/mlflow/artifacts --host=0.0.0.0 --port=5000 --serve-artifacts'
print(f'running command: {mlflow_command}')
proc = Popen([mlflow_command], shell=True,
             stdin=None, stdout=None, stderr=None, close_fds=True)
print(f'waiting 5 seconds...')
time.sleep(5) # we wait 5 seconds to give the server time to start

# create the tracking uri string
uri = 'http://0.0.0.0:5000' # in our example, this is always the same

# set our variables 
project_name = 'test_project'
run_name = 'run_3'

model_configs = {
    'EPOCHS': 10,
    'BATCH_SIZE': 12,
    'LEARNING_RATE': 0.001,
    'WARMUP_EPOCHS': 4,
    'WARMUP_LR': 1e-06,
    'INNER_ACTIVATIONS': 'relu',
    'LAST_ACTIVATION': 'softmax',
    'LOSS_FUNCTION': 'CategoricalCrossentropy',
    'BN_MOMEN': 0.5
                }

model_architecture = 'architecture_3'
last_activation = 'softmax'

# set the URI
print(f'setting tracking uri: {uri}')
mlflow.set_tracking_uri(uri)

# set your experiment name. if it does not exists, it will be created
mlflow.set_experiment(experiment_name=project_name)

# start your experiment
mlflow.start_run(run_name=run_name)

print(f'logging params...')
mlflow.log_params(model_configs)
mlflow.set_tags({'model_architecture': model_architecture,
                 'last_activation': last_activation,
                }
               )

# creating an image and saving it as an artifact
print(f'saving image artifact...')
sns.set_context("talk")
cur_plot_title = "Test plot"
a_plot = sns.scatterplot(x=[1,2], y=[1,2])
sns.set(rc = {'figure.figsize':(8,8)})
plt.tight_layout()
cur_plot_name = f"{cur_plot_title}.png"
a_plot.figure.savefig(cur_plot_name)
mlflow.log_artifact(cur_plot_name)

# end your experiment
print(f'ending run...')
mlflow.end_run()
print(f'done')