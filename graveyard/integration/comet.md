# Integrate Run:ai with Comet

[Comet](https://www.comet.com/site/){target=_blank} builds tools that help data scientists, engineers, and team leaders accelerate and optimize machine learning and deep learning models. The purpose of this document is to explain how to run Jobs with MLflow using the Run:ai scheduler.

Data scientists and ML engineers choose the Comet platform because it has the flexibility required for the most iterative data science teams, and it is built to handle the intense demands of enterprise ML at scale.

To configure Comet integration:

1. Login to your account in [Comet](https://www.comet.com/site/){target=_blank}. If you do not have a valid account, you will need to create one.
2. Setup your Comet account [here](https://www.comet.com/docs/v2/guides/getting-started/quickstart/){target=_blank}.
3. In your Run:ai account, create an [environment](../../Researcher/user-interface/workspaces/create/create-env.md){target=_blank} and set Comet as a tool then:
   1. Enter the following `<COMET_results_URL>`
   2. Add an environment variable:
   
        ```Key = COMET_results_URL```

        ```Value = enter the URL destination for the results```

The researcher must then create a [Workspace](../../Researcher/user-interface/workspaces/create/workspace.md) and select the Comet tool.

To configure the Comet tool, for the environemnt variable name `COMET_results_URL` value, enter the ULR of the destination where the results are to be delivered.

This will create a link, that will automatically open a new tab directly from your Workspace to your exact Comet project.
