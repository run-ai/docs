# Install and configure CLI

This article explains the procedure for installing and configuring the researcher Command Line Interface.

### Prerequisites

* Ensure the Improved command line interface toggle is enabled, under **General settings** → Workloads
* Only clusters that are version 2.18 or above are supported.

### Installing the CLI

1. Click the **Help (?)** icon in the top-right corner
2. Select **Researcher Command Line Interface**
3. Select the **cluster** you want the CLI to communicate with
4. Select your computer’s **operating system**
5. Copy the installer command and run it in the terminal
6. Follow the installation process instructions
7. Click `Enter` to use the default values (recommended)

#### Testing the installation

To verify the CLI client was installed properly

1. Open the terminal
2. Run the command `runai version`

### Configuring the CLI

Follow the steps below to configure the CLI.

#### Authenticating the CLI

After installation, sign in to the Run:ai platform to authenticate the CLI.

1. Open the terminal on your local machine
2. Run `runai login`
3. Enter your username and password in the Run:ai platform's sign-in page
4. Return to the terminal window to use the CLI

#### Setting a default cluster

If only one cluster is connected to the account, it is set as the default cluster when you first sign-in. If there are multiple clusters, you must follow the steps below to set your preferred cluster for workload submission:

1. Open the terminal on your local machine
2. Run `runai cluster list` to find the required cluster name
3. Run the following command `runai cluster set --name <CLUSTER NAME>`

#### Setting a default project

Set a default working project, to easily submit workloads wihtout mentioning the project name in every command.

1.  Run the following command on the terminal:

    `runai project set --name=<project_name>`
2. If successful, the following message is returned:\
   `project <project name> configured successfully`
3.  To see the current configuration run:

    `runai config generate --json`

#### Installing command auto-completion

Auto-completion assists with completing the command syntax automatically for ease-of-use. Auto-completion is installed automatically. The interfaces below require manual installation:

<details>

<summary>Installation instructions for ZSH</summary>

1. Edit the file `~/.zshrc`
2.  Add the following code:

    ```
    autoload -U compinit; compinit -i
    source <(runai completion zsh)
    ```

</details>

<details>

<summary>Installation instructions for Bash</summary>

1. Install the bash-completion package
2.  Choose your operating system:\
    Mac: `brew install bash-completion`

    Ubuntu/Debian: `sudo apt-get install bash-completion`

    Fedora/Centos: `sudo yum install bash-completion`
3.  Edit the file `~/.bashrc` and add the following lines:

    ```bash
    [[ -r “/usr/local/etc/profile.d/bash_completion.sh” ]] && . “/usr/local/etc/profile.d/bash_completion.sh”
     
    source <(runai completion bash)
    ```

</details>

<details>

<summary>Installation instructions for Windows</summary>

Add the following code in the powershell profile:

```powershell
runai.exe completion powershell | Out-String | Invoke-Expression
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
```

For more completion modes options, see [Powershell completions](https://github.com/spf13/cobra/blob/main/site/content/completions/_index.md#powershell-completions).

</details>
