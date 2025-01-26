# Installing the V2 Command-line interface

This article explains the procedure for installing and configuring the __new__ researcher Command Line Interface (CLI). 

!!! Important
      This document refers to the new CLI which only works with clusters of version 2.18 and up. 
      The installation instructions for the older CLI are [here](cli-install.md).



## Enabling the V2 CLI

Under **General settings** → Workloads, enable the flag `Improved command line interface`

## Installing the CLI

1. Click the **Help (?)** icon in the top right corner  
2. Select **Researcher Command Line Interface**  
3. Select the **cluster** you want the CLI to communicate with  
4. Select your computer’s **operating system**  
5. Copy the installer command and run it in the terminal or download the binary file for **Windows** OS
6. Follow the installation process instructions  
7. Click `Enter` to use the default values (recommended)

### Testing the installation

To verify the CLI client was installed properly

1. Open the terminal  
2. Run the command `runai version`

## Configuring the CLI

Follow the steps below to configure the CLI.


### Setting the Control plane URL
**The following step is required for Windows users only. Linux and Mac clients are configured via the installation script automatically**

Run the command `runai config set --cp-url <CONTROL_PLANE_URL>`. 
This will also create the `config.json` file in the default path

### Authenticating the CLI

After installation, sign in to the Run:ai platform to authenticate the CLI:

1. Open the terminal on your local machine. 
2. Run `runai login`.
3. Enter your username and password on the Run:ai platform's sign-in page. 
4. Return to the terminal window to use the CLI.

### Setting the default cluster

If only one cluster is connected to the account, it is set as the default cluster when you first sign in.  
 If there are multiple clusters, you must follow the steps below to set your preferred cluster for workload submission:

1. Open the terminal on your local machine.  
2. Run `runai cluster` and select the desried cluster from the interactive menu

alernativly  

1. Open the terminal on your local machine.  
2. Run `runai cluster list` to find the desired cluster name.  
3. Run the following command `runai cluster set <CLUSTER_NAME>`

### Setting a default project

Set a default working project, to easily submit workloads without mentioning the project name in every command.


1. Open the terminal on your local machine.  
2. Run `runai project` and select the desried cluster from the interactive menu

alernativly  

1. Open the terminal on your local machine.  
2. Run `runai cluster list` to find the desired project name.  
3. Run the following command `runai project set <PROJECT_NAME>`  
4. If successful, the following message is returned `project <PROJECT_NAME> configured successfully`  


### Validating the configuration
To view the current configuration run `runai config generate --json`

### Installing command auto-completion

Auto-completion assists with completing the command syntax automatically for ease of use. Auto-completion is installed automatically.  
 The interfaces below require manual installation:

=== "Zsh"
      1. Edit the file `~/.zshrc`  
      2. Add the following code:

      ``` bash
      autoload -U compinit; compinit -i
      source <(runai completion zsh)
      ```

=== "Bash"
      1. Install the bash-completion package  
      2. Choose your operating system:  
         Mac: `brew install bash-completion`  
         Ubuntu/Debian: `sudo apt-get install bash-completion`  
         Fedora/Centos: `sudo yum install bash-completion`  
      3. Edit the file `~/.bashrc` and add the following lines:

      ``` bash
      [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion
      source <(runai completion bash)
      ```

=== "Windows"
    Add the following code in the powershell profile:
    ```powershell
    runai.exe completion powershell | Out-String | Invoke-Expression
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
    ```
    For more completion modes options, see [Powershell completions](https://github.com/spf13/cobra/blob/main/site/content/completions/_index.md#powershell-completions).
