# Researcher Library: Hyperparameter Optimization Support

The Run:ai Researcher Library is a python library you can add to your deep learning python code. The hyperparameter optimization(HPO) support module of the library is a helper library for hyperparameter optimization (HPO) experiments


Hyperparameter optimization (HPO) is the process of choosing a set of optimal hyperparameters for a learning algorithm. A hyperparameter is a parameter whose value is used to control the learning process. Example hyperparameters: Learning rate, Batch size, Different optimizers, number of layers.

To search for good hyperparameters, Researchers typically start a series of small runs with different hyperparameter values, let them run for a while, and then examine the results to decide what works best.

With the reporter module, you can externalize information such as progress, accuracy, and loss over time/epoch, and more. In addition, you can externalize custom metrics of your choosing.


## Getting Started

### Prerequisites

Run:ai HPO library is dependent on [PyYAML](https://github.com/yaml/pyyaml){target=_blank}.
Install it using the command:

```
pip install pyyaml
```

### Installing

Install the `runai` Python library using `pip` using the following command:

```
pip install runai
```

> Make sure to use the correct `pip` installer (you might need to use `pip3` for Python3)

### Usage

* Import the ``runai.hpo`` package.

```
import runai.hpo
```

* Initialize the Run:ai HPO library with a path to a directory shared between all cluster nodes (typically using an NFS server).
We recommend specifying a unique name for the experiment, the name will be used to create a sub-directory on the shared folder.
To do so, we recommend using the [environment variables](../../best-practices/env-variables/) `JOB_NAME` and `JOB_UUID` which are injected to the container by Run:ai.

``` python
hpo_root = '/path/to/nfs'
hpo_experiment = '%s_%s' % (os.getenv('JOB_NAME'), os.getenv('JOB_UUID'))

runai.hpo.init(hpo_root, hpo_experiment)
```

* Decide on an HPO strategy:
    *  Random search - randomly pick a set of hyperparameter values
    *  Grid search - pick the next set of hyperparameter values, iterating through all sets across multiple experiments

``` python
strategy = runai.hpo.Strategy.GridSearch
```


* Call the Run:ai HPO library to specify a set of hyperparameters and pick a specific configuration for this experiment.

``` python
config = runai.hpo.pick(
    grid=dict(
        batch_size=[32, 64, 128],
        lr=[1, 0.1, 0.01, 0.001]),
    strategy=strategy)
```

* Use the returned configuration in your code. For example:

```
optimizer = keras.optimizers.SGD(lr=config['lr'])
```

Metrics could be reported and saved in the experiment directory under the fule ``runai.yaml`` using `runai.hpo.report`.
You should pass the epoch number and a dictionary with metrics to be reported. For example:

``` python
runai.hpo.report(epoch=5, metrics={ 'accuracy': 0.87 })
```

## See Also

* See hyperparameter Optimization [Quickstart](../Walkthroughs/walkthrough-hpo.md)
* Sample code in [Github](https://github.com/run-ai/docs/tree/master/quickstart/hpo){target=_blank}
