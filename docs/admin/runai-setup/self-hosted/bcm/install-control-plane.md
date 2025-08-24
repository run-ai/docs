# Install the Control Plane

Installing the NVIDIA Run:ai control plane requires Internet connectivity.


## System and Network Requirements
Before installing the NVIDIA Run:ai control plane, validate that the [system requirements](./system-requirements.md) and [network requirements](./network-requirements.md) are met. Make sure you have the [software artifacts](./preparations.md) prepared.

## Permissions

As part of the installation, you will be required to install the NVIDIA Run:ai control plane [Helm chart](https://helm.sh/). The Helm charts require Kubernetes administrator permissions. You can review the exact objects that are created by the charts using the `--dry-run` flag on both helm charts.

## Installation

Run the following command. Replace `global.domain=<DOMAIN>` with the one  obtained [here](./system-requirements.md#fully-qualified-domain-name-fqdn)

```bash
helm upgrade -i runai-backend -n runai-backend runai-backend/control-plane \
--version "<VERSION> " \
--set global.customCA.enabled=true \
--set global.domain=<DOMAIN>
```

!!! Note
    To install a specific version, add --version <VERSION> to the install command. You can find available versions by running helm search repo -l runai-backend.

## Connect to NVIDIA Run:ai User Interface

1. Open your browser and go to: `https://<DOMAIN>`.
2. Log in using the default credentials:
    
    * User: `test@run.ai`
    * Password: `Abcd!234`

You will be prompted to change the password.

