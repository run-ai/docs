import http.client
import requests
import json
import random
import string


# Application Name and Secret must be created in the Run:AI User Interface. See https://docs.run.ai/developer/rest-auth/
APPNAME = '<key-name>'
APPSECRET = '<secret>'


# the URL is the URL to the Run:AI User Interface
APPURL = 'https://app.run.ai'
COMPANYURL = 'https://<company-name>.run.ai'

# REALM is obtained by going to the Run:AI User Interface, and getting the REALM and "Researcher Authentication"
REALM = '<realm>'

# The department feature is advanced and is mostly disabled. 
# Find out the default department ID by listing departments via https://app.run.ai/api/docs/#/Departments/get_v1_k8s_departments
DEPARTMENT_ID = 1234  

# A tenant (customer) may define multiple clusters. 
# Find out the Cluster UUID by logging into the Administraor user interface and go to "Clusters"
CLUSTER_UUID = '000000-0000-0000-0000-0000000000'


#Generate a random string of fixed length 
def randomString(stringLength=10):
    letters = string.ascii_letters
    digits = string.digits
    return ''.join(random.choice(letters) for i in range(stringLength)) + random.choice(digits)



def login():
    payload = "grant_type=client_credentials&client_id=" + APPNAME + "&client_secret=" + APPSECRET
    headers = { 'content-type': 'application/x-www-form-urlencoded'    }
    url = APPURL + '/auth/realms/' + REALM + '/protocol/openid-connect/token'

    r = requests.post(url, headers=headers, data=payload)

    if r.status_code //100 == 2:
 #       print (r.text)
        jcontents = json.loads(r.text)
        return jcontents['access_token']
    
    else:
        print("login error: " + r.text)
        exit(1)




def create_researcher_user(uid, pwd, token):

    payload =  {
        "roles": ["admin","editor"],
        "permittedClusters" : [],
        "name":"",
        "password": pwd,
        "email" : uid,
        "permitAllClusters":True,
        "username" : uid,
        "needToChangePassword" : True
    }


    headers = \
        {'content-type': 'application/json', 
        'Accept': 'application/json',
        'Authorization' : 'Bearer {}'.format(token)}
    r = requests.post(COMPANYURL + '/v1/k8s/users', json=payload, headers=headers)
 
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
        "permissions": {
            "users": [internalUID]
        }
    }
    headers = \
        {'content-type': 'application/json', 
        'Accept': 'application/json',
        'Authorization' : 'Bearer {}'.format(token)
        }
    r = requests.post(COMPANYURL + '/v1/k8s/clusters/' + CLUSTER_UUID + '/projects', json=payload, headers=headers)
 
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