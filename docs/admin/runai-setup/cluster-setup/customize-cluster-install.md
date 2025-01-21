This article explains the available configurations for customizing the Run:ai cluster installation.

## Helm chart values

The Run:ai cluster installation can be customized to support your environment via Helm [values files](https://helm.sh/docs/chart_template_guide/values_files/) or [Helm install](https://helm.sh/docs/helm/helm_install/) flags.

These configurations are saved in the runaiconfig Kubernetes object and can be edited post-installation as needed. For more information, see [Advanced Cluster Configurations](../../config/advanced-cluster-config.md).

### Values

The following table lists the available Helm chart values that can be configured to customize the Run:ai cluster installation.

| Key | Description | Default | 
| --- | --- | --- |
| global.image.registry (string) | Global Docker image registry | Default: `""` |
| global.additionalImagePullSecrets (list) | List of image pull secrets references| Default: `[]` |
| spec.researcherService.ingress.tlsSecret (string) | Existing secret key where cluster TLS Certificates are stored (non-OpenShift) | Default: `runai-cluster-domain-tls-secret` |
| spec.researcherService.route.tlsSecret (string) | Existing secret key where cluster TLS Certificates are stored (OpenShift only) | Default: `` |
| spec.prometheus.spec.image (string) | Due to a known issue In the Prometheus Helm chart, the imageRegistry setting is ignored. To pull the image from a different registry, you can manually specify the Prometheus image reference. | Default: `quay.io/prometheus/prometheus` |
| spec.prometheus.spec.imagePullSecrets (string) | List of image pull secrets references in the runai namespace to use for pulling Prometheus images (relevant for air-gapped installations). | Default: `[]` | 