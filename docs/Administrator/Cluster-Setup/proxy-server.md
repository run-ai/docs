## Introduction

Run:AI is installed on GPU clusters. These clusters must have outbound internet connectivity to the Run:AI cloud. Details can be found here:  [Run-AI-GPU-Cluster-Prerequisites](cluster-prerequisites.md) under "Network Requirements".

In some organizations, outbound connectivity requires a proxy. Traffic originating from servers and browsers within the organizations flows through a gateway that inspects the traffic, calls the destination and returns the contents. 

Organizations sometimes employ a further security measure by signing packets with an organizational certificate.  The software initiating the HTTP request must acknowledge this certificate, otherwise, it would interpret it as a man-in-the-middle attack. 

In-case the certificate is not trusted (or is a self-signed certificate), this certificate must be included in Run:AI configuration for outbound connectivity to work.

## Run:AI Configuration

The instructions below receive as input a certificate file from the organization and deploy it into the Run:AI cluster so that traffic originating in Run:AI will recognize the organizational proxy server.

The Run:AI cluster installation is performed by accessing the Administrator User Interface at [app.run.ai](https://app.run.ai/) downloading a YAML file ``runai-operator.yaml`` and then applying it to Kubernetes. You must edit the YAML file. 

Search for ``httpProxy``:

``` yaml
httpProxy:
    enabled: false
    tlsCert: |-
    -----BEGIN CERTIFICATE-----
    <CERTIFICATE_CONTENTS>
    -----END CERTIFICATE-----
```

Set ``enabled`` to true and paste the contents of the certificate under ``tlsCert``.