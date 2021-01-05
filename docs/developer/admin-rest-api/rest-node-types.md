







Add node type
curl -X POST 'https://app.run.ai/v1/k8s/nodeType' \
  -H 'authorization: Bearer Qh7TXpUacJQ' \
  -H 'content-type: application/json' \
  --data-binary '{"clusterUuid":"f53d75b6-f826-4420-9fa9-5ea75392cef4","name":"v-100"}' 

{"tenantId":44,"createdAt":"2021-01-05T07:18:25.297Z","clusterUuid":"f53d75b6-f826-4420-9fa9-5ea75392cef4","name":"v-100","id":20}

----
Get node types
curl 'https://app.run.ai/v1/k8s/clusters/f53d75b6-f826-4420-9fa9-5ea75392cef4/nodeTypes' \
  -H 'authorization: Bearer eyJhbGciOiJSUJQ' \
  -H 'content-type: application/json' 

[{"id":20,"tenantId":44,"clusterUuid":"f53d75b6-f826-4420-9fa9-5ea75392cef4","name":"v-100","dependProjectIds":[],"dependProjectNames":[]}]


