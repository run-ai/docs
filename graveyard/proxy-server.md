## Introduction

Run:ai is installed on GPU clusters. These clusters must have outbound internet connectivity to the Run:ai cloud. Details can be found here:  [Run-AI-GPU-Cluster-Prerequisites](cluster-prerequisites.md) under "Network Requirements".

In some organizations, outbound connectivity requires a proxy. Traffic originating from servers and browsers within the organizations flows through a gateway that inspects the traffic and forwards it to its destination.

Organizations sometimes employ a further security measure by signing packets with an organizational certificate.  The software initiating the HTTP request must acknowledge this certificate, otherwise, it would interpret it as a man-in-the-middle attack. 

In-case the certificate is not trusted (or is a self-signed certificate), this certificate must be included in Run:ai configuration for outbound connectivity to work.

## Run:ai Configuration

The instructions below receive as input a certificate file from the organization and deploy it into the Run:ai cluster so that traffic originating in Run:ai will recognize the organizational proxy server.

The Run:ai cluster installation is performed by accessing the Run:ai User Interface at `<company-name>.run.ai` downloading a YAML file ``runai-operator.yaml`` and then applying it to Kubernetes. You must edit the YAML file. 

Search for ``httpProxy``:

``` YAML
global:
...
    httpProxy:
        enabled: false
        proxyUrl: http://<proxy-url>:<proxy-port>
        tlsCert: |-
        -----BEGIN CERTIFICATE-----
        <CERTIFICATE_CONTENTS>
        -----END CERTIFICATE-----
```

* Set ``enabled`` to true 
* Set the proxy URL and Port.
* Paste the contents of the certificate under ``tlsCert``.