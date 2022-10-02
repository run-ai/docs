# Configure existing Prometheus Adapter
  
Prerequisites:
- yq

<br />
Steps:

1. Get the Prometheus Adapter rules from the Run:ai chart values, under `prometheus-adapter.rules`.

```bash
helm repo update
helm show values runai/runai-cluster | yq '.prometheus-adapter.rules' > runai_prom_adapter_rules.yaml
```
2. Locate the prometheus adapter helm release name and namespace
```bash
helm list -A
```
3. Get current release values
```bash
helm get values -n <RELEASE_NAMESPACE> <RELEASE_NAME> -oyaml > current_prom_adapter_values.yaml
```
4. Merge the rules from step 1 with the values from step 3, and upgrade the release with the new values.
```bash
helm upgrade -n <RELEASE_NAMESPACE> <RELEASE_NAME> <CHART_NAME> -f <MERGED_VALUES_FILE>
```

For further information please contact Run:ai customer support.
