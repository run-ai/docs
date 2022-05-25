# Run:ai Documentation Library

Welcome to the Run:ai documentation area. For an introduction about what is the Run:ai Platform see [Run:ai platform](https://www.run.ai/platform/){target=_blank} on the run.ai website


The Run:ai documentation is targeting three personas:

* Run:ai Administrator - Responsible for the setup and the day-to-day administration of the product. Administrator documentation can be found [here](./admin/overview-administrator.md).

* Researcher - Using Run:ai to submit Jobs. Researcher documentation can be found [here](./Researcher/overview-researcher.md).

* Developer - Using various APIs to manipulate Jobs and integrate with other systems. Developer documentation can be found [here](./developer/overview-developer.md).

## How to get Support

To get support use the following channels:

* Write to [support@run.ai](mailto:support@run.ai).

* On the navigation bar of the Run:ai user interface at `<company-name>.run.ai`, use the 'Support' button.

* Or submit a ticket by clicking the button below:

[Submit a Ticket](https://runai.secure.force.com/casesupport/CreateCaseForm){target=_blank .md-button .md-button--primary }



## Run:ai Cloud Status Page

Run:ai cloud availabilty is monitored at [status.run.ai](https://status.run.ai){target=_blank}.

## Collect Logs to Send to Support

As an IT Administrator, you can collect Run:ai logs to send to support:

* Install the [Run:ai Administrator command-line interface](admin/runai-setup/config/cli-admin-install.md).
* Use one of the two options:
    1. __One time collection:__  Run `runai-adm collect-logs`. The command will generate a compressed file containing all of the existing Run:ai log files.
    2. __Continuous send__ (Run:ai version 2.5 or higher): Run `runai-adm -d <HOURS_DURATION>`. The command will send Run:ai logs directly to Run:ai support for the duration stated. Data sent will not include current logs. Only logs created going forward will be sent.

!!! Note
    Both options include logs of Run:ai components. They do __not__ include logs of researcher containers that may contain private information. 

## Example Code

Code for the Docker images referred to on this site is available at [https://github.com/run-ai/docs/tree/master/quickstart](https://github.com/run-ai/docs/tree/master/quickstart){target=_blank}.
