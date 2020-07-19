# Introduction

Run:AI is installed on GPU clusters. These clusters must have outbound internet connectivity to the Run:AI cloud. Details can be found here:&nbsp;<https://support.run.ai/hc/en-us/articles/360010227960-Run-AI-GPU-Cluster-Prerequisites>&nbsp;under "Network Requirements"

In some organizations, outbound connectivity is proxied. Traffic originating from servers and browsers within the organizations flows through a gateway that inspects the traffic, calls the destination and returns the contents.&nbsp;

Organizations sometimes employ a further security measure by&nbsp;signing packets with an organizational certificate.&nbsp; The software initiating the HTTP request must acknowledge this certificate, otherwise, it would interpret it as a man-in-the-middle attack.&nbsp;

In-case the certificate is not trusted (or is a self-signed certificate), this certificate must be included in Run:AI configuration for outbound connectivity to work.

# Run:AI Configuration

The instructions below receive as input a certificate file from the organization and deploy it into the Run:AI cluster so that traffic originating in Run:AI will recognize the organizational proxy server.

<span>A Run:AI cluster is installed by accessing the Administrator User Interface at </span><a href="https://app.run.ai/" rel="noopener" target="_blank">app.run.ai</a><span> downloading a yaml file </span>_runai-operator.yaml&nbsp;_<span>and then </span>_applying_<span> it to Kubernetes. You must edit the yaml file. Search for _httpProxy_</span>

<pre>global:<br/>  httpProxy:<br/>    enabled: false<br/>    tlsCert: |-<br/>      -----BEGIN CERTIFICATE-----<br/>      &lt;CERTIFICATE_CONTENTS&gt;<br/>      -----END CERTIFICATE-----</pre>

Set _enabled_&nbsp;to true and paste the contents of the certificate under _tlsCert_