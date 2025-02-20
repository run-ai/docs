# Customized installation

This article explains the available configurations for customizing the Run:ai cluster installation.

## Helm chart values

The Run:ai cluster installation can be customized to support your environment via Helm [values files](https://helm.sh/docs/chart_template_guide/values_files/) or [Helm install](https://helm.sh/docs/helm/helm_install/) flags.

These configurations are saved in the `runaiconfig` Kubernetes object and can be edited post-installation as needed. For more information, see [Advanced Cluster Configurations](../advanced-setup/advanced-cluster-configurations.md).

The following table lists the available Helm chart values that can be configured to customize the Run:ai cluster installation.

| Key                                                 | Description                                                                                                                                                                                                                                                                                                                                             |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| global.image.registry _(string)_                    | <p>Global Docker image registry<br>Default: <code>""</code></p>                                                                                                                                                                                                                                                                                         |
| global.additionalImagePullSecrets _(list)_          | <p>List of image pull secrets references<br>Default: <code>[]</code></p>                                                                                                                                                                                                                                                                                |
| spec.researcherService.ingress.tlsSecret _(string)_ | <p>Existing secret key where cluster <a href="install-using-helm.md#tls-certificates">TLS certificates</a> are stored (non-OpenShift)<br>Default: <code>runai-cluster-domain-tls-secret</code></p>                                                                                                                                                      |
| spec.researcherService.route.tlsSecret _(string)_   | <p>Existing secret key where cluster <a href="install-using-helm.md#tls-certificates">TLS certificates</a> are stored (OpenShift only)<br>Default: <code>""</code></p>                                                                                                                                                                                  |
| spec.prometheus.spec.image _(string)_               | <p>Due to a <a href="https://github.com/prometheus-community/helm-charts/issues/4734">known issue</a> In the Prometheus Helm chart, the <code>imageRegistry</code> setting is ignored. To pull the image from a different registry, you can manually specify the Prometheus image reference.<br>Default: <code>quay.io/prometheus/prometheus</code></p> |
| spec.prometheus.spec.imagePullSecrets _(string)_    | <p>List of image pull secrets references in the <code>runai</code> namespace to use for pulling Prometheus images (relevant for air-gapped installations).<br>Default: <code>[]</code></p>                                                                                                                                                              |
