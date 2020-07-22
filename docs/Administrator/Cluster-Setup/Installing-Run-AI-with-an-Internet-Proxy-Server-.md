## Introduction

Run:AI is installed on GPU clusters. These clusters must have outbound internet connectivity to the Run:AI cloud. Details can be found here:  [Run-AI-GPU-Cluster-Prerequisites](Run-AI-GPU-Cluster-Prerequisites.md) under "Network Requirements".

In some organizations, outbound connectivity is proxied. Traffic originating from servers and browsers within the organizations flows through a gateway that inspects the traffic, calls the destination and returns the contents. 

Organizations sometimes employ a further security measure by signing packets with an organizational certificate.  The software initiating the HTTP request must acknowledge this certificate, otherwise, it would interpret it as a man-in-the-middle attack. 

In-case the certificate is not trusted (or is a self-signed certificate), this certificate must be included in Run:AI configuration for outbound connectivity to work.

## Run:AI Configuration

The instructions below receive as input a certificate file from the organization and deploy it into the Run:AI cluster so that traffic originating in Run:AI will recognize the organizational proxy server.

 A Run:AI cluster is installed by accessing the Administrator User Interface at  <a href="https://app.run.ai/" rel="noopener" target="_blank">app.run.ai</a>  downloading a yaml file  _runai-operator.yaml_ and then  _applying_  it to Kubernetes. You must edit the yaml file. Search for _httpProxy_

    global:
    httpProxy:
        enabled: false
        tlsCert: |-
        -----BEGIN CERTIFICATE-----
        <CERTIFICATE_CONTENTS>
        -----END CERTIFICATE-----

Set _enabled_ to true and paste the contents of the certificate under _tlsCert_.