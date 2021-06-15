import http.client
import requests
import json
import random
import string


# Unique user and Key should be provided by Run:AI Support
USER = '<from support>
KEY = '<from support>'

# The department feature is advanced and is mostly disabled. 
# Find out the default department ID by listing departments via https://docs.run.ai/developer/admin-rest-api/departments/
DEPARTMENT_ID = 6   

# A tenant (customer) may define multiple clusters. 
# Find out the Cluster UUID by logging into https://app.run.ai/clusters
CLUSTER_UUID = '000000-0000-0000-0000-0000000000'



# Generate a random string of fixed length 
def randomString(stringLength=10):
    letters = string.ascii_letters
    digits = string.digits
    return ''.join(random.choice(letters) for i in range(stringLength)) + random.choice(digits)



def login():
    payload = {
        "email": USER,
        "password": KEY
    }
    headers = {
        'content-type': 'application/json', 
        'Accept': 'application/json'
    }
    r = requests.post('https://app.run.ai/v1/k8s/auth/login', headers=headers, json=payload)

    if r.status_code //100 == 2:
 #       print (r.text)
        jcontents = json.loads(r.text)
        return jcontents['access_token']
    
    else:
        print("login error: " + r.text)
        exit(1)




def create_researcher_user(uid, pwd, token):
    payload = {
        "email": uid,
        "password": pwd,
        "roles": [
            "researcher",
            "viewer"
        ],
        "permittedClusters": [],
        "permitAllClusters": True,
        "needToChangePassword": True
        }
    headers = \
        {'content-type': 'application/json', 
        'Accept': 'application/json',
        'Authorization' : 'Bearer {}'.format(token)}
    r = requests.post('https://app.run.ai/v1/k8s/users', json=payload, headers=headers)
 
    if r.status_code //100 == 2:
 #       print (r.text)
        jcontents = json.loads(r.text)
        return jcontents['userId']
    
    else:
        print("login error: " + r.text)
        exit(1)




def create_project(projectname, internalUID, gpuquota, token):
    payload = {
        "name": projectname,
        "departmentId": DEPARTMENT_ID,
        "deservedGpus": gpuquota,
        "clusterUuid": CLUSTER_UUID,
        "swapEnabled": False,
        "permissions": {
            "users": [internalUID]
        }
    }
    headers = \
        {'content-type': 'application/json', 
        'Accept': 'application/json',
        'Authorization' : 'Bearer {}'.format(token)
        }
    r = requests.post('https://app.run.ai/v1/k8s/projects', json=payload, headers=headers)
 
    if r.status_code //100 == 2:
#        print (r.text)
        jcontents = json.loads(r.text)
        return jcontents['id']
    
    else:
        print("create project error: " + r.text)
        exit(1)



def user_setup(username, projectname, gpuquota):
    access_token = login()
    pwd = randomString(20)
    internalUID = create_researcher_user(username, pwd, access_token)
    print("password: " + pwd)
    create_project(projectname, internalUID, gpuquota, access_token)
    return

# Create a user John, with its own Run:AI project and a quota of 2 GPUs.
user_setup("john@acme.com", "john-project", 2)