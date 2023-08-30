import requests
import json

# see https://docs.run.ai/v2.13/developer/rest-auth/
CONTROL_PLANE = "https://url"
REALM = "runai"
CLIENT_ID = "obtained by creating an application"
CLIENT_SECRET = "obtained by creating an application"
CLUSTER_UUID = "obtained by viewing the cluster list in the UI and adding a UUID column"

def main():
    return

def login():
    url = CONTROL_PLANE + "/auth/realms/" + REALM + "/protocol/openid-connect/token"

    payload = 'grant_type=client_credentials&scope=openid&response_type=id_token&client_id=' + CLIENT_ID + '&client_secret=' + CLIENT_SECRET
    headers = {
        'Content-Type': 'application/x-www-form-urlencoded'
    }

     
    response = requests.request("POST", url, headers=headers, data=payload)
    if response.status_code //100 == 2:
        j = json.loads(response.text)
        return j["access_token"]
    else:
        print(json.dumps(json.loads(response.text), sort_keys=True, indent=4, separators=(",", ": ")))
        return



def get_jobs(bearer, project):
    
    # all filters are optional. E.g.
    # can remove "project:" to get all projects
    # can add one or more job types
    # Other options: sortBy=status&sortDirection=asc&from=0&limit=20 
    # or any other option filtered or sorted in the Jobs UI

    url = CONTROL_PLANE + "/v1/k8s/clusters/" + CLUSTER_UUID + "/jobs?filter=project:"+ project + "&jobType:Train|Interactive" 
    

    print (url)

    headers = {
    'Authorization': "Bearer " + bearer,
    'Content-Type': 'application/json',
    }

    response = requests.request("GET", url, headers=headers) #, data=payload)

    if response.status_code //100 == 2:
        print(json.dumps(json.loads(response.text), sort_keys=True, indent=4, separators=(",", ": ")))
    else:
        print(response.text)





if __name__ == "__main__":
   
   bearer = login()
   project="team-a"
   get_jobs(bearer, project)
   main()