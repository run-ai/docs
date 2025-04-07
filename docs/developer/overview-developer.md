!!! runai "📣 The NVIDIA Run:ai docs are moving!"
      
    We’ve launched a new documentation site to improve navigation, clarity, and access to the latest features starting from NVIDIA Run:ai v2.20 and above. Visit [NVIDIA Run:ai documentation](https://docshub.run.ai).

    Documentation for versions **2.19 and below** will remain on this site.


# Overview

Developers can access Run:ai through various programmatic interfaces.

## API Support

The endpoints and fields specified in the [API reference](https://app.run.ai/api/docs) are the ones that are officially supported by Run:ai. Endpoints and fields that are not listed in the API reference are not supported.

Run:ai does not recommend using API endpoints and fields marked as `deprecated` and will not add functionality to them. Once an API endpoint or field is marked as `deprecated`, Run:ai will stop supporting it after 2 major releases for self-hosted deployments, and after 6 months for SaaS deployments.

For details, see the [Deprecation notifications](../home/whats-new-2-17.md#deprecation-notifications).

## API Architecture

Run:ai is composed of a single, multi-tenant control plane. Each tenant can be connected to one or more GPU clusters. See [Run:ai system components](../home/components.md) for detailed information.

Below is a diagram of the Run:ai API Architecture. A developer may:

1. Access the control plane via the _Administrator API_.
2. Access any one of the GPU clusters via _Cluster API_.
3. Access cluster metrics via the _Metrics API_.  

![api architecture image](img/api-architecture.png)

## Administrator API

Add, delete, modify and list Run:ai meta-data objects such as Projects, Departments, Users, and more.

The API is provided as REST and is accessible via the control plane endpoint.  

For more information see [Administrator REST API](admin-rest-api/overview.md).

## Cluster API

Submit and delete Workloads.

The API is provided as [Kubernetes API](./cluster-api/submit-yaml.md).

Cluster API is accessible via the GPU cluster itself. As such, **multiple clusters may have multiple endpoints**.

!!! Note
    The same functionality is also available via the [Run:ai Command-line interface](../Researcher/cli-reference/Introduction.md). The CLI provides an alternative for automating with shell scripts.

## Metrics API

Retrieve metrics from multiple GPU clusters.

See the [Metrics API](metrics/metrics.md) document.

## API Authentication

See [API Authentication](rest-auth.md) for information on how to gain authenticated access to Run:ai APIs.
