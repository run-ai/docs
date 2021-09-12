
Run:AI has two (web-based) User Interfaces: The Administration user interface and the Researcher user interface. 


## Administration User Interface

Browse to `https://runai.<company-name>`, enter user `test@run.ai` and password `password`. Change the password under the __Permissions__ area. 


## Resarcher User Interface

* Enable Researcher Authentrication. The [server-side](../researcher-authentication/#server-side) configuration is mandatory in this context.
* If you have set a self-signed certificate in the [backend](backend.md) installation, you must provide Kubernetes with the root-ca certificate. 
    * Copy the root-ca certificate to `/etc/ssl/certs`
    * Edit the Kubernetes API Server configuration file as mentioned in the last bullet and add `--oidc-ca-file=/etc/ssl/certs/<name of root ca certificate file>`


Browse to `https://runai.<company-name>/researcher`.

