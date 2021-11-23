# Run:AI Documentation Library

Welcome to the Run:AI documentation area. For an introduction about what is the Run:AI Platform see [Run:AI platform](https://www.run.ai/platform/){target=_blank} on the run.ai website


The Run:AI documentation is targeting three personas:

* Run:AI Administrator - Responsible for the setup and the day-to-day administration of the product. Administrator documentation can be found [here](./admin/overview-administrator.md).

* Researcher - Using Run:AI to submit Jobs. Researcher documentation can be found [here](./Researcher/overview-researcher.md).

* Developer - Using various APIs to manipulate Jobs and integrate with other systems. Developer documentation can be found [here](./developer/overview-developer.md).

## Example Code

Code for the Docker images referred to on this site is available at [https://github.com/run-ai/docs/tree/master/quickstart](https://github.com/run-ai/docs/tree/master/quickstart){target=_blank}.


## How to get Support

To get support use the following channels:

* Write to [support@run.ai](mailto:support@run.ai).

* On the navigation bar of the Administrator user interface at [app.run.ai](https://app.run.ai){target=_blank}, use the 'Support' button.

* Or submit a ticket by clicking the button below:

[Submit a Ticket](https://runai.secure.force.com/casesupport/CreateCaseForm){target=_blank .md-button .md-button--primary }



## Run:AI Cloud Status Page

Run:AI cloud availabilty is monitored at [status.run.ai](https://status.run.ai){target=_blank}.

## Collect Logs to Send to Support

As an IT Administrator, you can collect Run:AI logs to send to support:

* Install the [Run:AI Administrator command-line interface](admin/runai-setup/advanced/cli-admin-install.md).
* Run `runai-adm collect-logs`. The command will generate a compressed file containing all of Run:AI logs files.

!!! Note
    The file includes logs of Run:AI components. It does __not__ include logs of researcher containers that may contain private information. 