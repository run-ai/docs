# Preparations 

You should receive a token from NVIDIA Run:ai customer support. The following command provides access to the NVIDIA Run:ai container registry: 

```
kubectl create secret docker-registry runai-reg-creds  \
--docker-server=https://runai.jfrog.io \
--docker-username=self-hosted-image-puller-prod \
--docker-password=<$TOKEN> \
--docker-email=support@run.ai \
--namespace=runai-backend 
```

