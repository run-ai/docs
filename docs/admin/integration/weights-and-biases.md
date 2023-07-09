# Weights and Biases

Weights and Biases is a commercial tool that provides experiment tracking, model visualization, and collaboration for machine learning projects. It helps researchers and developers keep track of their experiments, visualize their results, and compare different models to make informed decisions.

When Wights and Biases are integrated into Run:ai Workspaces, researchers can easily create their custom work environments and have access to a toolbox of many researcher-relevant tools in a single place. Researchers can now create useful connectivity between the running Workspace and the relevant project using Weights Biases for experiment tracking.

To configure Weights and Biases:

1. Login to your account in [Weights and Biases](https://wandb.ai/site{target=_blank}). If you do not have a valid account, you will need to create one.
2. Setup your Weights and Biases account [here](https://docs.wandb.ai/quickstart#1.-set-up-wandb{target=_blank})
3. In your Run:ai account, create an [environment](../../Researcher/user-interface/workspaces/create/create-env.md) and set Weights and Biases as a tool then:
   1. Enter the following `<WANDB_results_URL>`
   2. Add an environment variable:
   
        ```Key = WANDB_results_URL```

        ```Value = enter the URL destination for the results```
        
The researcher must then create a [Workspace](../../Researcher/user-interface/workspaces/create/workspace.md) and select the Weights and Biases tool.

To configure the Weights and Biases tool, for the environemnt variable name `WANDB_results_URL` value, enter the ULR of the destination where the results are to be delivered.

This will create a link, that will automatically open a new tab directly from your Workspace to your exact Weights and Biases project.

## Sweep configuration

Sweep is Weight & Biases' tool for performing hyperparameters search & optimization. see more in https://docs.wandb.ai/guides/sweeps

To enable the WANDB sweep feature:

1. Open the settings page.
2. Toggle on the wandb sweep feature and enter the base URL, then press save.

To submit a sweep configuration for your Run:ai job:

1. Open the submit job page, ans select *training*.
2. Open the *WANDB sweep*** section, and toggle the *Sweep configuration* switch.
3. Enter your YAML configuration file or paste it into the editor.
4. Enter the Weight & Biases entity name.
5. Enter the Weights & Biases project name (optional).
6. Enter the Weights & Biases API Key.
7. Enter a count (optional).

After you have completed the job setup, press submit.

If successful, you should see in the logs that the job is running and a connection to wandb's.
Then, go to your wandb web app, open the sweeps page, then open the last sweep created, you should see data there.
