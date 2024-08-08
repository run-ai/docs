# Run:ai Documentation Library


Welcome to the Run:ai documentation area. For an introduction about what is the Run:ai Platform see [Run:ai platform](https://www.run.ai/platform/){target=_blank} on the run.ai website.

The Run:ai documentation is targeting four personas:

* __Infrastructure Administrator__ - An IT person, responsible for the installation, setup and IT maintenance of the Run:ai product. Infrastructure Administrator documentation can be found [here](../admin/overview-administrator.md).

* __Platform Administrator__ - Responsible for the day-to-day administration of the product. Platform Administrator documentation can be found [here](../platform-admin/overview.md).


* __Researcher__ — Using Run:ai to spin up notebooks, submit Workloads, prompt models, etc. Researcher documentation can be found [here](../Researcher/overview-researcher.md).

* __Developer__ — Using various APIs to manipulate Workloads, deploy models, and integrate with other systems. Developer documentation can be found [here](../developer/overview-developer.md).

## How to Get Support

To get support use the following channels:

* On the Run:ai user interface at `<company-name>.run.ai`, use the 'Contact Support' link on the top right.

* Or submit a ticket by clicking the button below:

[Submit a Ticket](https://runai.secure.force.com/casesupport/CreateCaseForm){target=_blank .md-button .md-button--primary }



## Community 

Run:ai provides its customers with access to the _Run:ai Customer _Community portal_ to submit tickets, track ticket progress and update support cases.

[Customer Community Portal](https://runai-support.force.com/community/s/){target=_blank .md-button .md-button--primary }

Reach out to customer support for credentials.


## Run:ai Cloud Status Page

Run:ai cloud availability is monitored at [status.run.ai](https://status.run.ai){target=_blank}.

## Collect Logs to Send to Support

As an IT Administrator, you can collect Run:ai logs to send to support:

* Install the [Run:ai Administrator command-line interface](../admin/runai-setup/config/cli-admin-install.md).
* Run `runai-adm collect-logs`. The command will generate a compressed file containing all of the existing Run:ai log files.

!!! Note
    The tar file packages the logs of Run:ai components only. It does __not__ include logs of researcher containers that may contain private information. 

## Example Code

Code for the Docker images referred to on this site is available at [https://github.com/run-ai/docs/tree/master/quickstart](https://github.com/run-ai/docs/tree/master/quickstart){target=_blank}.

The following images are used throughout the documentation:

|  Image | Description | Source |
|--------|-------------|--------|
| [gcr.io/run-ai-demo/quickstart](https://gcr.io/run-ai-demo/quickstart){target=_blank} | Basic training image. Multi-GPU support | [https://github.com/run-ai/docs/tree/master/quickstart/main](https://github.com/run-ai/docs/tree/master/quickstart/main){target=_blank} | 
| [gcr.io/run-ai-demo/quickstart-distributed](https://gcr.io/run-ai-demo/quickstart-distributed){target=_blank} | Distributed training using MPI and Horovod | [https://github.com/run-ai/docs/tree/master/quickstart/distributed](https://github.com/run-ai/docs/tree/master/quickstart/distributed){target=_blank} | 
| [zembutsu/docker-sample-nginx](https://hub.docker.com/r/zembutsu/docker-sample-nginx) | Build (interactive) with Connected Ports | [https://github.com/zembutsu/docker-sample-nginx](https://github.com/zembutsu/docker-sample-nginx){target=_blank} | 
| [gcr.io/run-ai-demo/quickstart-hpo](https://gcr.io/run-ai-demo/quickstart-hpo) |  Hyperparameter Optimization  |[https://github.com/run-ai/docs/tree/master/quickstart/hpo](https://github.com/run-ai/docs/tree/master/quickstart/hpo){target=_blank} | 
| [gcr.io/run-ai-demo/quickstart-x-forwarding](https://gcr.io/run-ai-demo/quickstart-x-forwarding){target=_blank} | Use X11 forwarding from Docker image | [https://github.com/run-ai/docs/tree/master/quickstart/x-forwarding](https://github.com/run-ai/docs/tree/master/quickstart/x-forwarding){target=_blank} | 
| [gcr.io/run-ai-demo/pycharm-demo](https://gcr.io/run-ai-demo/pycharm-demo){target=_blank} | Image used for tool integration (PyCharm and VSCode) | [https://github.com/run-ai/docs/tree/master/quickstart/python%2Bssh](https://github.com/run-ai/docs/tree/master/quickstart/python%2Bssh){target=_blank} |
| [gcr.io/run-ai-demo/example-triton-client](https://gcr.io/run-ai-demo/example-triton-client){target=_blank} and  [gcr.io/run-ai-demo/example-triton-server](https://gcr.io/run-ai-demo/example-triton-server){target=_blank} |  Basic Inference | [https://github.com/run-ai/models/tree/main/models/triton](https://github.com/run-ai/models/tree/main/models/triton){target=_blank} |

## Contributing to the documentation

This documentation is made better by individuals from our customer and partner community. If you see something worth fixing, please comment at the bottom of the page or create a pull request via GitHub. The public GitHub repository can be found on the top-right of this page. 
