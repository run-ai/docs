
Run:AI has two (web-based) User Interfaces: The Administration user interface and the Researcher user interface. 


## Administration User Interface

Browse to `https://runai.<company-name>`, enter user `test@run.ai` and password `password`. Change the password under the __Permissions__ area. 


## Researcher User Interface

* Enable Researcher Authentication. The [server-side](../../../config/researcher-authentication/#server-side) configuration is mandatory in this context.
* If you have set a self-signed certificate in the Run:AI [Control Plane](backend.md) installation, you must provide Kubernetes with the root-ca certificate. 
    * Copy the certificate authority file (e.g. `ca.pem`) to `/etc/ssl/certs`
    * Edit the Kubernetes API Server configuration file as mentioned in the last bullet and add `--oidc-ca-file=/etc/ssl/certs/<name of CA file>`


Browse to `https://runai.<company-name>/researcher`.

## Next Steps

Continue to [create Run:AI Projects](project-management.md).
