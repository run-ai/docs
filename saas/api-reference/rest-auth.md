# How to authenticate to the API

The following document explains how to authenticate with Run:ai APIs.

Run:ai APIs are accessed using _bearer tokens_. A token can be obtained by creating an **Application** through the Run:ai user interface.

An application contains a client ID and a client secret. With the client credentials you can obtain a token and use it within subsequent API calls.

* To create applications for your organization, see [Applications](../authentication-and-authorization/applications.md).
* To create your own user applications, see [User Applications](../authentication-and-authorization/user-applications.md).

## Request an API Token

Use the client credentials created to get a temporary token to access Run:ai as follows.

### Example command to get an API token

Replace `<runai_url>` below with:

* For SaaS installations, use `<tenant-name>.run.ai`
* For self-hosted use the Run:ai user interface URL.

{% tabs %}
{% tab title="cURL" %}
```bash
curl -X POST \ 'https://<runai_url>/api/v1/token' \ --header 'Accept: */*' \ --header 'Content-Type: application/json' \ --data-raw '{ "grantType":"client_credentials", "clientId":"<CLIENT ID>", "clientSecret" : "<CLIENT SECRET>" }'
```
{% endtab %}

{% tab title="Python" %}
```python
import requests import json reqUrl = "https://<runai_url>/api/v1/token" headersList = { "Accept": "*/*", "Content-Type": "application/json" } payload = json.dumps({ "grantType":"client_credentials", "clientId":"<CLIENT ID>", "clientSecret" : "<CLIENT SECRET>" }) response = requests.request("POST", reqUrl, data=payload, headers=headersList) print(response.text)
```
{% endtab %}
{% endtabs %}

### Response

The API response will look as follows:

```json
{
  "accessToken": "<TOKEN>", 
}
```

To call Run:ai REST APIs, the application must pass the retrieved `accessToken` as a _Bearer token_ in the Authorization header of your HTTP request.
