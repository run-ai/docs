# Installation

## Run:ai components

As part of the installation process, you will install:

* A control-plane managing cluster/s
* One or more clusters

Both the control plane and clusters require Kubernetes. Typically. the control plane and first cluster are installed on the same Kubernetes cluster but this is not a must.

{% hint style="info" %}
In OpenShift environments, adding a cluster connecting to a remote control plane currently requires the assistance of customer support.
{% endhint %}

### Installation types

The self-hosted option is for organizations that cannot use a SaaS solution due to data leakage concerns.

Run:ai self-hosting comes with two variants:

| Self-hosting Type | Description                                                                           |
| ----------------- | ------------------------------------------------------------------------------------- |
| Connected         | The organization can freely download from the internet (though upload is not allowed) |
| Air-gapped        | <p>The organization has no connection to the internet<br></p>                         |

The self-hosted installation is priced differently. For further information please talk to Run:ai sales.
