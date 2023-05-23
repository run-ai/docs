# Integrate Run:ai with Comet

[Comet](https://www.comet.com/site/){target=_blank} builds tools that help data scientists, engineers, and team leaders accelerate and optimize machine learning and deep learning models. The purpose of this document is to explain how to run Jobs with MLflow using the Run:ai scheduler.

Data scientists and ML engineers choose the Comet platform because it has the flexibility required for the most iterative data science teams, and it is built to handle the intense demands of enterprise ML at scale.

To configure Comet integration:

1. Login to your account in [Comet](https://www.comet.com/site/){target=_blank}. If you do not have a valid account, you will need to create one.
2. Setup your Comet account [here](https://www.comet.com/docs/v2/guides/getting-started/quickstart/){target=_blank}.
3. In your Run:ai account, create an [environment](../../Researcher/user-interface/workspaces/create/create-env.md){target=_blank} and set Comet as a tool then:
   1. Link it to https://www.comet.com/`user_name`/`project_name`/
   2. Add an environment variable:
   
        ```Key = COMET_PROJECT```

        ```Value =``` leave empty for researcher to fill it in when creating a Workspace in the next step.
4. Create a [Workspace](../../Researcher/user-interface/workspaces/create/workspace.md) using the Environment you just created.
5. In the Workspace, add the URL for your project in your Comet account to the `value` environment variable.

This will create a link, that will automatically open a new tab directly from your Workspace to your exact Comet project.
